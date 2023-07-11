import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/core/local/global_config.dart';
import 'package:taswqly/screens/terms_and_cond/controller/terms_and_cond_states.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import 'package:taswqly/shared/remote/dio.dart';

import '../model/terms_model.dart';

class TermsAndCondCubit extends Cubit<TermsAndCondStates> {
  TermsAndCondCubit() : super(TermsAndCondInitialState());

  static TermsAndCondCubit get(context) => BlocProvider.of(context);

  Map<dynamic,dynamic>? termsAndConditionResponse ;
  TermsAndConditionModel? model ;

  Future<void> getTerms({required BuildContext context}) async {
    emit(TermsAndConditionLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        if(CacheHelper.getData(key: AppCached.userToken) != null)
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      termsAndConditionResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.termsAndCond,
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      if (termsAndConditionResponse!['status'] == false) {
        debugPrint(termsAndConditionResponse.toString());
        emit(TermsAndConditionErrorState());
      } else {
        debugPrint(termsAndConditionResponse.toString());
        model = TermsAndConditionModel.fromJson(termsAndConditionResponse!);
        emit(TermsAndConditionSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

}