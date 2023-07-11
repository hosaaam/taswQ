import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taswqly/components/custom_toast.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/core/local/global_config.dart';
import 'package:taswqly/screens/auth/register/model/citeis_model.dart';
import 'package:taswqly/screens/edit_profile/model/update_profile_model.dart';
import 'package:taswqly/screens/my_account/view/my_account_view.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import 'package:taswqly/shared/remote/dio.dart';

import '../../btnNavBar/view/btn_nav_bar_view.dart';
import 'edit_profile_states.dart';

class EditProfileCubit extends Cubit<EditProfileStates> {
  EditProfileCubit() : super(EditProfileInitialState());

  static EditProfileCubit get(context) => BlocProvider.of(context);
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  String? dropDownValue;
  void changeDropDown(val) {
    dropDownValue = val;
    emit(ChangeDropDown());
  }


  File? file;
  void pickFromGallery({required BuildContext context}) async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 80);
    if (pickedFile == null) return;
    file = File(pickedFile.path);
    debugPrint(file!.path);
    emit(EditProfileImageState());
  }

  void pickFromCamera({required BuildContext context}) async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 80);
    if (pickedFile == null) return;
    file = File(pickedFile.path);
    debugPrint(file!.path);
    emit(EditProfileImageState());
  }

  Future<void> getData({required BuildContext context})async{
    dropDownValue = CacheHelper.getData(key: AppCached.userCityId).toString();
    nameCtrl.text = CacheHelper.getData(key: AppCached.userName);
    emailCtrl.text = CacheHelper.getData(key: AppCached.userEmail);
    await getCities(context: context);
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




  Map<dynamic, dynamic>? upDateImageResponse;

  Future<void> upDateImage({required BuildContext context}) async {
    emit(UpDateLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        'Authorization' : 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      FormData formData = FormData.fromMap({
        'photo': file == null ? null : await MultipartFile.fromFile(file!.path)
      });

      debugPrint(formData.toString());

      upDateImageResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.updateImage,
        methodType: 'post',
        context: context,
        dioBody: formData
      );

      if (upDateImageResponse!['status'] == false) {
        debugPrint('>>>>>>>>>>>>>>>> UpDate Image Find Error <<<<<<<<<<<<<<');
        debugPrint(upDateImageResponse.toString());
        showToast(text: upDateImageResponse!['message'],state: ToastStates.error);
        emit(UpDateImageErrorState());

      } else {
        debugPrint(upDateImageResponse.toString());
        CacheHelper.saveData(AppCached.userPhoto,  upDateImageResponse!['data']);
        emit(UpDateImageSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }


  Map<dynamic, dynamic>? upDateProfileResponse;
  UpdateProfileModel? updateProfileModel ;

  Future<void> upDateProfile({required BuildContext context}) async {

    emit(UpDateLoadingState());

    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        'Authorization' : 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      final formData = ({
        'name': nameCtrl.text,
        'city_id': dropDownValue,
        'email': emailCtrl.text
      });

      debugPrint(formData.toString());

      upDateProfileResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.updateProfile,
        methodType: 'post',
        context: context,
        dioBody: formData,
      );

      if (upDateProfileResponse!['status'] == false) {
        debugPrint(upDateProfileResponse.toString());
        showToast(text: upDateProfileResponse!['message'],state: ToastStates.error);
        emit(UpDateProfileErrorState());

      } else {
        debugPrint(upDateProfileResponse.toString());
        showToast(text: upDateProfileResponse!['message'],state: ToastStates.success);
        updateProfileModel = UpdateProfileModel.fromJson(upDateProfileResponse!);
        saveDataToShared(updateProfileModel!.data!);
        navigateAndFinish(context: context, widget: const BottomNavBar());
        //navigateAndReplace(context: context, widget: const MyAccountScreen());
        emit(UpDateProfileSuccessState());

      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }

  }


  saveDataToShared(DataUser user) async {
    debugPrint('Start Saving data');
    CacheHelper.saveData(AppCached.userId, user.id);
    CacheHelper.saveData(AppCached.userCityName, user.cityName);
    CacheHelper.saveData(AppCached.userCityId, user.cityId);
    CacheHelper.saveData(AppCached.userName, user.name);
    CacheHelper.saveData(AppCached.userPhoto, user.photo);
    CacheHelper.saveData(AppCached.userEmail, user.email);
    CacheHelper.saveData(AppCached.userBalance, user.balance);
    CacheHelper.saveData(AppCached.userNotify, user.isNotify);
    debugPrint('Finish Saving data');
  }

}