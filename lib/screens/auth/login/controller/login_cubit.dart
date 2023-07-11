import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_toast.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/core/local/global_config.dart';
import 'package:taswqly/screens/auth/pin_code/view/pin_code_view.dart';

import '../../../../components/deviceId.dart';
import '../../../../core/local/app_cached.dart';
import '../../../../shared/local/cache_helper.dart';
import '../../../../shared/remote/dio.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  String? phone;
  Map<dynamic, dynamic>? loginResponse;

  // String? token
  // getToken() async {
  //   token = await FirebaseMessaging.instance.getToken();
  //   debugPrint(token);
  // }
  void getPhone(String phoneNumber) {
    phone = phoneNumber;
    emit(GetPhoneCompleteState());
  }
  final phoneCtrl = TextEditingController();
  var formKey = GlobalKey<FormState>();
  Future<void> login({required BuildContext context}) async {
    // await getToken();
    if (!formKey.currentState!.validate()) return;
    emit(LoginLoadingState());
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

      loginResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.sendCode,
        methodType: 'post',
        dioBody: formData,
        context: context,
      );
      debugPrint(loginResponse.toString());

      if (loginResponse!['status'] == false) {
        debugPrint(loginResponse.toString());
        showToast(text: loginResponse!['message'], state: ToastStates.error);
        emit(LoginFailureState());
      } else {
        debugPrint(loginResponse.toString());
        showToast(text: loginResponse!['message'], state: ToastStates.success);

        navigateTo(context:context, widget:  PinCodeScreen(phone: phone!));
        phoneCtrl.clear();
        emit(LoginSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

}