import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_toast.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/core/local/global_config.dart';
import 'package:taswqly/screens/more/model/links_model.dart';
import 'package:taswqly/screens/my_account/controller/my_account_states.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import 'package:taswqly/shared/remote/dio.dart';

class MyAccountCubit extends Cubit<MyAccountStates> {
  MyAccountCubit() : super(MyAccountInitialState());

  static MyAccountCubit get(context) => BlocProvider.of(context);

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