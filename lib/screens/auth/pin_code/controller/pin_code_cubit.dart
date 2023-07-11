import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/deviceId.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/core/local/global_config.dart';
import 'package:taswqly/screens/auth/pin_code/model/verify_model.dart';
import 'package:taswqly/screens/auth/register/view/register_view.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import 'package:taswqly/shared/remote/dio.dart';

import '../../../../components/custom_toast.dart';
import '../../../btnNavBar/view/btn_nav_bar_view.dart';
import 'pin_code_states.dart';

class PinCodeCubit extends Cubit<PinCodeStates> {
  PinCodeCubit() : super(PinCodeInitialState());

  static PinCodeCubit get(context) => BlocProvider.of(context);

  final pinCtrl = TextEditingController();
  Map<dynamic, dynamic>? pinCodeResponse;
  VerifyModel? model ;

  Future<void> activeAcc({required BuildContext context , required String phone}) async {

    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
      };

      final formData = ({
        'phone': phone,
        'code': pinCtrl.text,

      });

      debugPrint(formData.toString());

      pinCodeResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.activeCode,
        methodType: 'post',
        dioBody: formData,
        context: context,
      );
      debugPrint(formData.toString());

      if (pinCodeResponse!['status'] == false) {
        debugPrint(pinCodeResponse.toString());
        showToast(text: pinCodeResponse!['message'], state: ToastStates.error);
        emit(ActiveAccFailureState());
      } else {
        debugPrint(pinCodeResponse.toString());
        model = VerifyModel.fromJson(pinCodeResponse!);
        showToast(text: pinCodeResponse!['message'], state: ToastStates.success);
        saveDataToShared(firstLogin: model!.data!.firstLogin!,token:model!.data!.token! ,user: model!.data!.user!);
        pinCtrl.clear();
        CacheHelper.getData(key: AppCached.firstLogin) == false ? navigateAndFinish(context: context,widget: const BottomNavBar()):navigateTo(context:context, widget: const RegisterScreen());
        emit(ActiveAccSuccessState());

      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

  saveDataToShared({required User user, required String token,required bool firstLogin}) async {
    debugPrint("Start Saving Data");
    CacheHelper.saveData(AppCached.userId, user.id);
    CacheHelper.saveData(AppCached.userName, user.name);
    CacheHelper.saveData(AppCached.userCityId, user.cityId);
    CacheHelper.saveData(AppCached.userCityName, user.cityName);
    CacheHelper.saveData(AppCached.userPhoto, user.photo);
    CacheHelper.saveData(AppCached.userEmail, user.email);
    CacheHelper.saveData(AppCached.userNotify, user.isNotify);
    CacheHelper.saveData(AppCached.userBalance, user.balance);
    CacheHelper.saveData(AppCached.userToken, token);
    CacheHelper.saveData(AppCached.firstLogin, firstLogin);
    debugPrint("Finishing Saving Data");
  }

  Map<dynamic, dynamic>? resendCodeResponse;

  // String? token
  // getToken() async {
  //   token = await FirebaseMessaging.instance.getToken();
  //   debugPrint(token);
  // }
  Future<void> resendCode({required BuildContext context,required String phone}) async {
    // await getToken();
    emit(ResendLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
      };

      final formData = ({
        'phone': phone,
        'device_id': await getId(),
        'token_firebase': "token",
      });

      debugPrint(formData.toString());

      resendCodeResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.sendCode,
        methodType: 'post',
        dioBody: formData,
        context: context,
      );

      if (resendCodeResponse!['status'] == false) {
        debugPrint(resendCodeResponse.toString());
        showToast(text: resendCodeResponse!['message'], state: ToastStates.error);
        emit(ResendFailureState());
      } else {
        debugPrint(resendCodeResponse.toString());
        showToast(text: resendCodeResponse!['message'], state: ToastStates.success);
        emit(ResendSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

}