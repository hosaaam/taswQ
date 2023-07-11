import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_toast.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/core/local/global_config.dart';
import 'package:taswqly/screens/auth/login/view/login_view.dart';
import 'package:taswqly/screens/more/model/links_model.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import 'package:taswqly/shared/remote/dio.dart';

import 'more_states.dart';

class MoreCubit extends Cubit<MoreStates> {
  MoreCubit() : super(MoreInitialState());

  static MoreCubit get(context) => BlocProvider.of(context);
  Map<dynamic,dynamic>? logoutResponse ;

  Future<void> logOut({required BuildContext context}) async {
    emit(LogOutLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      logoutResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.logout,
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      if (logoutResponse!['status'] == false) {
        showToast(text: logoutResponse!['message'], state: ToastStates.error);
        debugPrint(logoutResponse.toString());
        emit(LogOutErrorState());
      } else {
        showToast(text: logoutResponse!['message'], state: ToastStates.success);
        debugPrint(logoutResponse.toString());
        navigateAndFinish(context: context, widget: const LoginScreen());
        CacheHelper.removeData(AppCached.userToken);
        emit(LogOutSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

  Map<dynamic,dynamic>? linksResponse ;
  LinksModel? linksModel ;

  Future<void> getLinks({required BuildContext context}) async {
    emit(LinksLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      linksResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.links,
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      if (linksResponse!['status'] == false) {
        showToast(text: linksResponse!['message'], state: ToastStates.error);
        debugPrint(linksResponse.toString());
        emit(LinksErrorState());
      } else {
        debugPrint(linksResponse.toString());
        linksModel = LinksModel.fromJson(linksResponse!);
        emit(LinksSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }


}