import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/core/local/global_config.dart';
import 'package:taswqly/screens/faq/model/faq_model.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import 'package:taswqly/shared/remote/dio.dart';

import 'faq_states.dart';

class FaqCubit extends Cubit<FaqStates> {
  FaqCubit() : super(FaqInitialState());

  static FaqCubit get(context) => BlocProvider.of(context);

  bool isExpanded = false ;

  void change(bool expanded,int index){
    isExpanded = expanded ;
    emit(ChangeBoolean());
  }


  Map<dynamic, dynamic>? faQResponse;
  FaqModel? faQModel ;
  Future<void> fetchFaq({required BuildContext context}) async {
    emit(FaqLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      faQResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.faQ,
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      if (faQResponse!['status'] == false) {
        debugPrint(faQResponse.toString());
        emit(FaqFieldState());
      } else {
        debugPrint(faQResponse.toString());
        faQModel = FaqModel.fromJson(faQResponse!);
        emit(FaqSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }
}