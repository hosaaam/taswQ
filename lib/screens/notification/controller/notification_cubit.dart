import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_toast.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/core/local/global_config.dart';
import 'package:taswqly/screens/notification/model/notification_model.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import 'package:taswqly/shared/remote/dio.dart';

import 'notification_states.dart';

class NotificationCubit extends Cubit<NotificationStates> {
  NotificationCubit() : super(NotificationInitialState());

  static NotificationCubit get(context) => BlocProvider.of(context);


  Map<dynamic, dynamic>? notificationsResponse;
  NotificationsModel? notificationsModel ;
  Future<void> fetchNotifications({required BuildContext context}) async {
    emit(NotificationsLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };
        print(CacheHelper.getData(key: AppCached.userToken));
      notificationsResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.notifications,
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      if (notificationsResponse!['status'] == false) {
        debugPrint(notificationsResponse.toString());
        emit(NotificationsFieldState());
      } else {
        debugPrint(notificationsResponse.toString());
        notificationsModel = NotificationsModel.fromJson(notificationsResponse!);
        emit(NotificationsSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

  Map<dynamic, dynamic>? deleteAllNotifyResponse;
  Future<void> deleteAllNotify({required BuildContext context}) async {
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      deleteAllNotifyResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.deleteAllNotify,
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      if (deleteAllNotifyResponse!['status'] == false) {
        debugPrint(deleteAllNotifyResponse.toString());
        showToast(text: deleteAllNotifyResponse!['message'], state: ToastStates.error);
        emit(NotificationsFieldState());
      } else {
        debugPrint(deleteAllNotifyResponse.toString());
        showToast(text: deleteAllNotifyResponse!['message'], state: ToastStates.success);
        notificationsModel!.data!.day!.clear();
        notificationsModel!.data!.yesterday!.clear();
        emit(NotificationsSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }


  Map<dynamic, dynamic>? deleteNotifyResponse;
  Future<void> deleteNotify({required BuildContext context, required String?id, required bool?today}) async {
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      deleteNotifyResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.deleteNotify + id.toString(),
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      if (deleteNotifyResponse!['status'] == false) {
        debugPrint(deleteNotifyResponse.toString());
        emit(NotificationsFieldState());
      } else {
        debugPrint(deleteNotifyResponse.toString());
        today==false?
        notificationsModel!.data!.yesterday!.removeWhere((element) => element.id==id):
        notificationsModel!.data!.day!.removeWhere((element) => element.id==id);
        emit(NotificationsSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }


}