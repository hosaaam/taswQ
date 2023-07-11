import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/style/images.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/core/local/global_config.dart';
import 'package:taswqly/screens/home/model/banners_model.dart';
import 'package:taswqly/screens/home/model/categories_model.dart';
import 'package:taswqly/screens/home/model/shops_model.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import 'package:taswqly/shared/remote/dio.dart';

import '../../../generated/locale_keys.g.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  List<String> images = [
    AppImages.grocery,
    AppImages.health,
    AppImages.electronics
  ] ;
  List<String> names = [
    LocaleKeys.Grocery.tr(),
    LocaleKeys.Health.tr(),
    LocaleKeys.Electronics.tr()
  ] ;
  List<String> namesGrid = [
    LocaleKeys.KingdomStore.tr(),
    LocaleKeys.KingdomPharmacy.tr()
  ] ;
  List<String> imagesGrid = [
    AppImages.superMarket,
    AppImages.pharmsy
  ] ;
  List<String> imageSlider = [
    AppImages.bgSlider,
    AppImages.bgSlider,
    AppImages.bgSlider
  ] ;

  int numSlider = 0;
  void changeSlider(int index) {
    numSlider = index;
    emit(ChangeSlider());
  }

  /// -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* fetch banners  -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
  Map<dynamic, dynamic>? bannersResponse;
  BannersModel? bannersModel ;
  Future<void> fetchBanners({required BuildContext context}) async {
    emit(BannersLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        if(CacheHelper.getData(key: AppCached.userToken) != null)
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      bannersResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.banners,
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      if (bannersResponse!['status'] == false) {
        debugPrint(bannersResponse.toString());
        emit(BannersFieldState());
      } else {
        debugPrint(bannersResponse.toString());
        bannersModel = BannersModel.fromJson(bannersResponse!);
        emit(BannersSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

  /// -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* fetch categories  -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

  Map<dynamic, dynamic>? categoriesResponse;
  CategoriesModel? categoriesModel ;
  Future<void> fetchCategories({required BuildContext context}) async {
    emit(CategoriesLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        if(CacheHelper.getData(key: AppCached.userToken) != null)
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };
      print(CacheHelper.getData(key: AppCached.userToken));
      categoriesResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.categories,
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      if (categoriesResponse!['status'] == false) {
        debugPrint(categoriesResponse.toString());
        emit(CategoriesFieldState());
      } else {
        debugPrint(categoriesResponse.toString());
        categoriesModel = CategoriesModel.fromJson(categoriesResponse!);
        emit(CategoriesSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }


  /// -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* fetch Shops  -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

  Map<dynamic, dynamic>? shopsResponse;
  ShopsModel? shopsModel ;
  Future<void> fetchShops({required BuildContext context}) async {
    emit(ShopsLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        if(CacheHelper.getData(key: AppCached.userToken) != null)
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      shopsResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.shops,
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      if (shopsResponse!['status'] == false) {
        debugPrint(shopsResponse.toString());
        emit(ShopsFieldState());
      } else {
        debugPrint(shopsResponse.toString());
        shopsModel = ShopsModel.fromJson(shopsResponse!);
        emit(ShopsSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

}