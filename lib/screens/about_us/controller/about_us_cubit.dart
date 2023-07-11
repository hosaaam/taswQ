import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/core/local/global_config.dart';
import 'package:taswqly/screens/about_us/model/about_app_model.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import 'package:taswqly/shared/remote/dio.dart';

import 'about_us_states.dart';

class AboutUsCubit extends Cubit<AboutUsStates> {
  AboutUsCubit() : super(AboutUsInitialState());

  static AboutUsCubit get(context) => BlocProvider.of(context);


  Map<dynamic,dynamic>? aboutAppResponse ;
  AboutAppModel? model ;

  Future<void> getAboutApp({required BuildContext context}) async {
    emit(AboutAppLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        if(CacheHelper.getData(key: AppCached.userToken) != null)
          'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      aboutAppResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.aboutApp,
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      if (aboutAppResponse!['status'] == false) {
        debugPrint(aboutAppResponse.toString());
        emit(AboutAppErrorState());
      } else {
        debugPrint(aboutAppResponse.toString());
        model = AboutAppModel.fromJson(aboutAppResponse!);
        emit(AboutAppSuccessState());
      }

    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }



}