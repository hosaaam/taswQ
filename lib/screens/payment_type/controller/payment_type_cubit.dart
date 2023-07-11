import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_toast.dart';
import 'package:taswqly/components/style/images.dart';
import 'package:taswqly/core/local/global_config.dart';
import 'package:taswqly/generated/locale_keys.g.dart';
import 'package:taswqly/screens/btnNavBar/model/auth_user_model.dart';
import 'package:taswqly/screens/payment_type/components/payment_success.dart';
import 'package:taswqly/screens/payment_type/controller/payment_type_states.dart';
import 'package:taswqly/shared/remote/dio.dart';

import '../../../components/navigation.dart';
import '../../../core/local/app_cached.dart';
import '../../../shared/local/cache_helper.dart';

class PaymentTypeCubit extends Cubit<PaymentTypeStates> {
  PaymentTypeCubit() : super(PaymentTypeInitialState());

  static PaymentTypeCubit get(context) => BlocProvider.of(context);
  List<String> images = [
    AppImages.credit,
    AppImages.wallet

  ];
  List<String> titles = [
    LocaleKeys.PaymentOnline.tr(),
    LocaleKeys.Wallet.tr()
  ];
  List<String> subTitles = [
    LocaleKeys.PayToOnline.tr(),
    LocaleKeys.PayToWallet.tr()
  ];

  Map<dynamic, dynamic>? payResponse;

  Future<void> finishOrder({required BuildContext context,required int type}) async {
    type == 0 ?emit(PayLoadingOnlineState()) :emit(PayLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };
      payResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: "${AllAppApiConfig.baseUrl}${AllAppApiConfig.payNow}is_wallet=$type",
        methodType: 'get',
        dioBody: null,
        context: context,
      );
      if (payResponse!['status'] == false) {
        debugPrint(payResponse.toString());
        showToast(text: payResponse!['message'], state: ToastStates.error);
        emit(PayFieldState());
      } else {
        debugPrint(payResponse.toString());
        navigateAndFinish(widget: const PaymentSuccess(),context: context);
        await getProfile(context: context);
        emit(PaySuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

  AuthUserModel? profileModel;
  Map<dynamic, dynamic>? profileResponse;
  Future<void> getProfile({required BuildContext context}) async {
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