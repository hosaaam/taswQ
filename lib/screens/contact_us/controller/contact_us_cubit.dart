import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_toast.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/core/local/global_config.dart';
import 'package:taswqly/screens/contact_us/model/contact_us_model.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import 'package:taswqly/shared/remote/dio.dart';

import '../../btnNavBar/view/btn_nav_bar_view.dart';
import 'contact_us_states.dart';

class ContactUsCubit extends Cubit<ContactUsStates> {
  ContactUsCubit() : super(ContactUsInitialState());

  static ContactUsCubit get(context) => BlocProvider.of(context);
  final nameCtrl = TextEditingController(text: CacheHelper.getData(key: AppCached.userName));
  final phoneCtrl = TextEditingController();
  final messageCtrl = TextEditingController();
  var formKey = GlobalKey<FormState>();


  Map<dynamic,dynamic>? getContactResponse ;
  GetContactUsModel? contactUsModel ;

  Future<void> getContact({required BuildContext context}) async {
    emit(GetContactLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      getContactResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.getContact,
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      if (getContactResponse!['status'] == false) {
        showToast(text: getContactResponse!['message'], state: ToastStates.error);
        debugPrint(getContactResponse.toString());
        emit(GetContactErrorState());
      } else {
        debugPrint(getContactResponse.toString());
        contactUsModel = GetContactUsModel.fromJson(getContactResponse!);
        emit(GetContactSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Map<dynamic,dynamic>? contactStoreResponse ;

  Future<void> contactStore({required BuildContext context}) async {
    if (!formKey.currentState!.validate()) return;
    emit(ContactStoreLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      final formData = ({
        'name': nameCtrl.text,
        'message': messageCtrl.text,
        'phone': phoneCtrl.text
      });

      debugPrint(formData.toString());

      contactStoreResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.contactStore,
        methodType: 'post',
        dioBody: formData,
        context: context,
      );

      if (contactStoreResponse!['status'] == false) {
        debugPrint(contactStoreResponse.toString());
        showToast(text: contactStoreResponse!['message'], state: ToastStates.error);
        emit(ContactStoreFailureState());
      } else {
        debugPrint(contactStoreResponse.toString());
        showToast(text: contactStoreResponse!['message'], state: ToastStates.success);
        navigateAndFinish(context:context,widget:  const BottomNavBar());
        emit(ContactStoreSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

}