import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_toast.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/core/local/global_config.dart';
import 'package:taswqly/generated/locale_keys.g.dart';
import 'package:taswqly/screens/cart/controller/cart_states.dart';
import 'package:taswqly/screens/cart/model/cart_model.dart';
import 'package:taswqly/screens/cart/model/delete_item.dart';
import 'package:taswqly/screens/notification/components/delete_popup.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import 'package:taswqly/shared/remote/dio.dart';

import '../../btnNavBar/view/btn_nav_bar_view.dart';


class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());

  static CartCubit get(context) => BlocProvider.of(context);

  // void plus(int counter){
  //   print(counter);
  //   counter++ ;
  //   print(counter);
  //   emit(PlusState());
  // }
  int? counter;
  void plus({required int id,required BuildContext context,required int index}) async {
    counter = cartModel!.data!.items![index].qty! + 1;
    print("counter " + index.toString());
    print("counter " + id.toString());
    updateCounter(context, id, index);
    emit(PlusState());
  }
  void minus({required int id,required BuildContext context,required int index}) async {
    if (cartModel!.data!.items![index].qty! > 1) {
      counter = cartModel!.data!.items![index].qty! - 1;
      print(counter);
      updateCounter(context, id, index);
    }
    emit(MinusState());
  }

  // void minus(int counter){
  //   if(counter>1){
  //     counter-- ;
  //     emit(MinusState());
  //   }
  // }


  Map<dynamic, dynamic>? cartResponse;
  CartModel? cartModel ;
  Future<void> fetchCart({required BuildContext context}) async {
    if(fromUpdate==false)
    emit(CartLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };
      print(CacheHelper.getData(key: AppCached.userToken));
      cartResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.cart,
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      print(CacheHelper.getData(key: AppCached.userToken));
      if (cartResponse!['status'] == false) {
        debugPrint(cartResponse.toString());
        emit(CartFieldState());
      } else {
        debugPrint(cartResponse.toString());
        cartModel = CartModel.fromJson(cartResponse!);
        emit(CartSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

  Map<dynamic, dynamic>? deleteResponse;
  DeleteItemModel? deleteItemModel ;
  Future<void> deleteItem({required BuildContext context,required int id}) async {
    fromUpdate=false;
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };
      deleteResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.deleteItem+id.toString(),
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      print(AllAppApiConfig.baseUrl + AllAppApiConfig.deleteItem+id.toString());
      if (deleteResponse!['status'] == false) {
        debugPrint(deleteResponse.toString());
        emit(CartFieldState());
      } else {
        debugPrint(deleteResponse.toString());
        fromUpdate=true;
        deleteItemModel = DeleteItemModel.fromJson(deleteResponse!);
        cartModel!.data!.items!.removeWhere((element) => element.cartId==id);
        fetchCart(context: context);
        // print("--- "+deleteItemModel!.data!.total!.toString());
        // cartModel!.data!.total=deleteItemModel!.data!.total!;
        emit(CartSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }


  bool fromUpdate=false;
  Map<dynamic, dynamic>? upDateCounterResponse;

  Future<void> updateCounter(context, int cartId, int index) async {
    final formData = ({
      'qty': counter,
      'cart_id': cartId,
    });

    print(formData);
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };
      upDateCounterResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.upDateItem,
        methodType: 'post',
        context: context,
        dioBody: formData,
      );

      if (upDateCounterResponse!['status'] == false) {
        print(upDateCounterResponse);
        emit(UpDateCounterCartErrorState());
      } else if (upDateCounterResponse!['status'] == true) {
        print(upDateCounterResponse.toString());
        print("counter "+cartModel!.data!.items![index].qty.toString());
        cartModel!.data!.items![index].qty = counter;
        print("counter after "+cartModel!.data!.items![index].qty.toString());
        emit(UpDateCounterCartErrorState());
        fromUpdate=true;
        fetchCart(context:context);
      }
    } catch (e, s) {
      print(e);
      print(s);
    }

    emit(CartInitialState());
    print('>>>>>>>>>>>>>> finishing Update Counter Plus cart >>>>>>>>>');
    //return {};
  }



  Map<dynamic, dynamic>? payResponse;

  Future<void> finishOrder({required BuildContext context}) async {
      emit(CartLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };
      payResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.payNow,
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      print(CacheHelper.getData(key: AppCached.userToken));
      if (payResponse!['status'] == false) {
        debugPrint(payResponse.toString());
        emit(CartFieldState());
      } else {
        debugPrint(payResponse.toString());
        showToast(text: payResponse!['message'], state: ToastStates.success);
        navigateAndFinish(context: context,widget: const BottomNavBar());
        // cartModel = CartModel.fromJson(payResponse!);
        emit(CartSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }


}