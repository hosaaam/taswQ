
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/core/local/global_config.dart';
import 'package:taswqly/screens/categoryDetails/controller/categoryDetails_states.dart';
import 'package:taswqly/screens/home/model/shops_model.dart';
import 'package:taswqly/screens/store/model/filter_model.dart';
import 'package:taswqly/screens/store/model/searchModel.dart';
import 'package:taswqly/screens/store_details/model/addFav_model.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import 'package:taswqly/shared/remote/dio.dart';

class CatDetailsCubit extends Cubit<CatDetailsStates> {
  CatDetailsCubit() : super(CatDetailsInitialState());

  static CatDetailsCubit get(context) => BlocProvider.of(context);

  ShopsModel? shopsModel ;

  /// -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* toggle fav -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

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
        emit(CatDetailsDetailsFieldState());
      } else {
        debugPrint(toggleFavResponse.toString());
        toggleFavModel = AddFavModel.fromJson(toggleFavResponse!);
        type == "search"?
        searchModel!.data![index].isFavorite = !searchModel!.data![index].isFavorite!:
        shopsModel!.data![index].isFavorite = !shopsModel!.data![index].isFavorite!;
        emit(CatDetailsDetailsSuccessState());
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
        emit(CatDetailsDetailsFieldState());
      } else {
        debugPrint(toggleFavResponse.toString());
        toggleFavModel = AddFavModel.fromJson(toggleFavResponse!);
        filterModel!.data![index].isFavorite = !filterModel!.data![index].isFavorite!;
        emit(CatDetailsDetailsSuccessState());
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
        emit(CatDetailsDetailsFieldState());
      } else {
        filterModel=null;
        debugPrint(searchResponse.toString());
        searchModel = SearchModel.fromJson(searchResponse!);
        emit(CatDetailsDetailsSuccessState());
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
        // navigatorPop(context: context);
        emit(CategoriesSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }
}