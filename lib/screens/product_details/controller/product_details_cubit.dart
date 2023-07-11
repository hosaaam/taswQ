import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_toast.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/core/local/global_config.dart';
import 'package:taswqly/screens/btnNavBar/view/btn_nav_bar_view.dart';
import 'package:taswqly/screens/product_details/controller/product_details_states.dart';
import 'package:taswqly/screens/product_details/model/productDetails_model.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import 'package:taswqly/shared/remote/dio.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsStates> {
  ProductDetailsCubit() : super(ProductDetailsInitialState());

  static ProductDetailsCubit get(context) => BlocProvider.of(context);

  int counter = 1 ;

  void plus(){
    counter++ ;
    emit(PlusState());
  }
  void minus(){
    if(counter>1){
      counter-- ;
    }
    emit(MinusState());
  }


  Map<dynamic, dynamic>? productDetailsResponse;
  ProductDetailsModel? productDetailsModel ;
  Future<void> fetchProductDetails({required BuildContext context,required String id}) async {
      emit(ProdDetailsLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };
      print(id.toString());
      productDetailsResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.prodDetails+id.toString(),
        methodType: 'get',
        dioBody: null,
        context: context,
      );
      if (productDetailsResponse!['status'] == false) {
        debugPrint(productDetailsResponse.toString());
        emit(ProdDetailsFieldState());
      } else {
        debugPrint(productDetailsResponse.toString());
        productDetailsModel = ProductDetailsModel.fromJson(productDetailsResponse!);
        emit(ProdDetailsSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

  Map<dynamic, dynamic>? addToCartResponse;
  Future<void> addToCart({required BuildContext context,required int? id}) async {
    emit(AddToCartLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };
      Map<String, dynamic> body = {
        'product_id': id!,
        'qty': counter,
      };
      debugPrint(body.toString() + " body");
      addToCartResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.addToCart,
        methodType: 'post',
        dioBody: body,
        context: context,
      );
  
      if (addToCartResponse!['status'] == false) {
        debugPrint(addToCartResponse.toString());
        showToast(text: addToCartResponse!['message'], state: ToastStates.error);
        emit(AddToCartFieldState());
      } else {
        debugPrint(addToCartResponse.toString());
        showToast(text: addToCartResponse!['message'], state: ToastStates.success);
        emit(AddToCartSuccessState());
        navigateAndFinish(context: context, widget: const BottomNavBar());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

}