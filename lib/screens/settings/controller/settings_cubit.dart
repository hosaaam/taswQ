import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_toast.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/core/local/global_config.dart';
import 'package:taswqly/screens/settings/controller/settings_states.dart';
import 'package:taswqly/screens/splash/splash_view.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import 'package:taswqly/shared/remote/dio.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(SettingsInitialState());

  static SettingsCubit get(context) => BlocProvider.of(context);





  bool notify = CacheHelper.getData(key: AppCached.userNotify) == false ? false : true;

  void toggleNotify(){
    notify= !notify;
    CacheHelper.saveData(AppCached.userNotify, notify == false ? false : true);
    emit(ChangeNotify());
  }


  Map<dynamic, dynamic>? activateNotifyResponse;

  Future<void> activateNotify({required BuildContext context}) async {

    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      activateNotifyResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.activeNotify,
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      if (activateNotifyResponse!['status'] == false) {
        showToast( text: activateNotifyResponse!['message'], state: ToastStates.error);
        emit(ChangeNotifyErrorState());
      } else {
        showToast( text: activateNotifyResponse!['message'], state: ToastStates.success);
        emit(ChangeNotifySuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }



  Map<dynamic,dynamic>? deleteAccResponse ;

  Future<void> deleteAcc({required BuildContext context}) async {
    emit(DeleteAccLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      deleteAccResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.deleteAcc,
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      if (deleteAccResponse!['status'] == false) {
        showToast(text: deleteAccResponse!['message'], state: ToastStates.error);
        debugPrint(deleteAccResponse.toString());
        emit(DeleteAccErrorState());
      } else {
        showToast(text: deleteAccResponse!['message'], state: ToastStates.success);
        debugPrint(deleteAccResponse.toString());
        CacheHelper.sharedPreferences.clear();
        navigateAndFinish(context: context, widget: const SplashScreen());
        emit(DeleteAccSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }




}