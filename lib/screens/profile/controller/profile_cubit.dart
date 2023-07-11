import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/core/local/global_config.dart';
import 'package:taswqly/screens/btnNavBar/model/auth_user_model.dart';
import 'package:taswqly/screens/profile/controller/profile_states.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import 'package:taswqly/shared/remote/dio.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  AuthUserModel? profileModel;
  Map<dynamic, dynamic>? profileResponse;
  Future<void> getProfile({required BuildContext context}) async {
    emit(ProfileLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      profileResponse = await myDio(
          appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
          dioHeaders: headers,
          url: AllAppApiConfig.baseUrl + AllAppApiConfig.authUser,
          methodType: 'get',
          context: context,
          dioBody: null);

      if (profileResponse!['status'] == false) {
        debugPrint(profileResponse.toString());
        emit(GetProfileErrorState());
      } else {
        debugPrint(profileResponse.toString());
        profileModel = AuthUserModel.fromJson(profileResponse!);
        saveDataToShared(profileModel!.data!);
        emit(GetProfileSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
    debugPrint('>>>>>>>>>>>>>> Finishing Getting Profile data Ok >>>>>>>>>');
  }


  saveDataToShared(Data user) async {
    debugPrint('Start Saving For Charge Balance');
    CacheHelper.saveData(AppCached.userNotify, user.isNotify);
    CacheHelper.saveData(AppCached.userName, user.name);
    CacheHelper.saveData(AppCached.userEmail, user.email);
    CacheHelper.saveData(AppCached.userId, user.id);
    CacheHelper.saveData(AppCached.userPhoto, user.photo);
    CacheHelper.saveData(AppCached.userBalance, user.balance);
    CacheHelper.saveData(AppCached.userCityName, user.cityName);
    CacheHelper.saveData(AppCached.userCityId, user.cityId);
    debugPrint('Finish Saving For Charge Balance');
  }

}