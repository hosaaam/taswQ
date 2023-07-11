import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_toast.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/core/local/global_config.dart';
import 'package:taswqly/screens/auth/register/model/citeis_model.dart';
import 'package:taswqly/screens/auth/register/model/confirm_register_model.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import 'package:taswqly/shared/remote/dio.dart';
import '../../../btnNavBar/view/btn_nav_bar_view.dart';
import 'register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);


  String? dropDownValue;
  void changeDropDown(val) {
    dropDownValue = val;
    emit(ChangeDropDown());
  }


  bool isChecked = false ;

  void check(value){
    isChecked = value ;
    emit(ChangeCheck());
  }


  Map<dynamic,dynamic>? citiesResponse ;
  CitiesModel? citiesModel ;

  Future<void> getCities({required BuildContext context}) async {
    emit(CitiesLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        if(CacheHelper.getData(key: AppCached.userToken) != null)
          'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      citiesResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.cities,
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      if (citiesResponse!['status'] == false) {
        debugPrint(citiesResponse.toString());
        emit(CitiesErrorState());
      } else {
        debugPrint(citiesResponse.toString());
        citiesModel = CitiesModel.fromJson(citiesResponse!);
        emit(CitiesSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }


  Map<dynamic, dynamic>? confirmRegisterResponse;
  final emailCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  var formKey = GlobalKey<FormState>();
  ConfirmRegisterModel? model ;
  Future<void> confirmRegister({required BuildContext context}) async {
    if (!formKey.currentState!.validate()) return;
    emit(ConfirmRegisterLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      final formData = ({
        'name': nameCtrl.text,
        'city_id': dropDownValue,
        'email': emailCtrl.text,
      });

      debugPrint(formData.toString());

      confirmRegisterResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.completeRegister,
        methodType: 'post',
        dioBody: formData,
        context: context,
      );

      if (confirmRegisterResponse!['status'] == false) {
        debugPrint(confirmRegisterResponse.toString());
        showToast(text: confirmRegisterResponse!['message'], state: ToastStates.error);
        emit(ConfirmRegisterFailureState());
      } else {
        debugPrint(confirmRegisterResponse.toString());
        showToast(text: confirmRegisterResponse!['message'], state: ToastStates.success);
        model = ConfirmRegisterModel.fromJson(confirmRegisterResponse!);
        saveDataToShared(user: model!.data!);
        navigateAndFinish(context:context,widget: const BottomNavBar());
        emit(ConfirmRegisterSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }


  saveDataToShared({required DataUser user}) async {
    debugPrint("Start Saving Data");
    CacheHelper.saveData(AppCached.userId, user.id);
    CacheHelper.saveData(AppCached.userName, user.name);
    CacheHelper.saveData(AppCached.userCityId, user.cityId);
    CacheHelper.saveData(AppCached.userCityName, user.cityName);
    CacheHelper.saveData(AppCached.userPhoto, user.photo);
    CacheHelper.saveData(AppCached.userEmail, user.email);
    CacheHelper.saveData(AppCached.userNotify, user.isNotify);
    CacheHelper.saveData(AppCached.userBalance, user.balance);
    debugPrint("Finishing Saving Data");
  }



}