import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/core/local/global_config.dart';
import 'package:taswqly/generated/locale_keys.g.dart';
import 'package:taswqly/screens/home/model/categories_model.dart';
import 'package:taswqly/screens/home/model/shops_model.dart';
import 'package:taswqly/screens/store/controller/store_states.dart';
import 'package:taswqly/screens/store/model/filter_model.dart';
import 'package:taswqly/screens/store/model/searchModel.dart';
import 'package:taswqly/screens/store_details/model/addFav_model.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import 'package:taswqly/shared/remote/dio.dart';

import '../../../components/style/images.dart';

class StoreCubit extends Cubit<StoreStates> {
  StoreCubit() : super(StoreInitialState());

  static StoreCubit get(context) => BlocProvider.of(context);
  List<String> names = [
    LocaleKeys.Grocery.tr(),
    LocaleKeys.MeatAndFish.tr(),
    LocaleKeys.SpecialtyStores.tr()
  ];

  List<String> namesList = [
    LocaleKeys.KingdomStore.tr(),
    LocaleKeys.KingdomPharmacy.tr(),
    LocaleKeys.KingdomStore.tr(),
    LocaleKeys.KingdomPharmacy.tr()
  ];

  List<String> subTitlesList = [
    LocaleKeys.Grocery.tr(),
    LocaleKeys.Health.tr(),
    LocaleKeys.Grocery.tr(),
    LocaleKeys.Health.tr()
  ];

  List<String> imagesList = [
    AppImages.superMarket,
    AppImages.pharmsy,
    AppImages.superMarket,
    AppImages.pharmsy
  ];


  /// -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* fetch Shops  -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

  Map<dynamic, dynamic>? shopsResponse;
  ShopsModel? shopsModel ;
  Future<void> fetchShops({required BuildContext context}) async {
    emit(ShopsLoadingState());
    filterModel=null;
    searchModel=null;
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        if(CacheHelper.getData(key: AppCached.userToken)!=null)
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
        isBack==true? null:
        await fetchCategories(context: context);
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

  /// -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* toggle fav -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

bool isBack=false;
  change(){
    isBack=true;
    emit(StoreInitialState());
  }
  Map<dynamic, dynamic>? toggleFavResponse;
  AddFavModel? toggleFavModel ;
  Future<void> toggleFav({required BuildContext context,required int id,required int index,required String type}) async {
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      toggleFavResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.toggleFav+id.toString(),
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      if (toggleFavResponse!['status'] == false) {
        debugPrint(toggleFavResponse.toString());
        emit(StoreDetailsFieldState());
      } else {
        debugPrint(toggleFavResponse.toString());
        toggleFavModel = AddFavModel.fromJson(toggleFavResponse!);
        type == "search"?
        searchModel!.data![index].isFavorite = !searchModel!.data![index].isFavorite!:
        shopsModel!.data![index].isFavorite = !shopsModel!.data![index].isFavorite!;
        emit(StoreDetailsSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }
  Future<void> toggleFavFilter({required BuildContext context,required int id,required int index}) async {
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      toggleFavResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.toggleFav+id.toString(),
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      if (toggleFavResponse!['status'] == false) {
        debugPrint(toggleFavResponse.toString());
        emit(StoreDetailsFieldState());
      } else {
        debugPrint(toggleFavResponse.toString());
        toggleFavModel = AddFavModel.fromJson(toggleFavResponse!);
        filterModel!.data![index].isFavorite = !filterModel!.data![index].isFavorite!;
        emit(StoreDetailsSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

  /// -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* Search -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*


  Map<dynamic, dynamic>? searchResponse;
  SearchModel? searchModel ;
  TextEditingController searchCtrl = TextEditingController();
  Future<void> search({required BuildContext context}) async {
    emit(SearchLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        if(CacheHelper.getData(key: AppCached.userToken)!=null)
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      searchResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.search,
        methodType: 'post',
        dioBody: {'search' : searchCtrl.text},
        context: context,
      );

      if (searchResponse!['status'] == false) {
        debugPrint(searchResponse.toString());
        emit(StoreDetailsFieldState());
      } else {
        filterModel=null;
        debugPrint(searchResponse.toString());
        searchModel = SearchModel.fromJson(searchResponse!);
        emit(StoreDetailsSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

  /// -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* fetch categories -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

  Map<dynamic, dynamic>? categoriesResponse;
  CategoriesModel? categoriesModel ;
  Future<void> fetchCategories({required BuildContext context}) async {
    emit(CategoriesLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        if(CacheHelper.getData(key: AppCached.userToken)!=null)
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };
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

  /// -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* fetch filter -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

  Map<dynamic, dynamic>? filterResponse;
  FilterModel? filterModel ;
  Future<void> filter({required BuildContext context ,required int id}) async {
    emit(CategoriesLoadingState());
    searchCtrl.clear();
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        if(CacheHelper.getData(key: AppCached.userToken)!=null)
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };
      filterResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.filter+id.toString(),
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      if (filterResponse!['status'] == false) {
        debugPrint(filterResponse.toString());
        emit(CategoriesFieldState());
      } else {
        searchModel=null;
        debugPrint(filterResponse.toString());
        filterModel = FilterModel.fromJson(filterResponse!);
        navigatorPop(context: context);
        emit(CategoriesSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }
}