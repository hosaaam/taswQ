import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/core/local/global_config.dart';
import 'package:taswqly/screens/favorites/model/fav_model.dart';
import 'package:taswqly/screens/store_details/model/addFav_model.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import 'package:taswqly/shared/remote/dio.dart';

import 'favorites_states.dart';

class FavoritesCubit extends Cubit<FavoritesStates> {
  FavoritesCubit() : super(FavoritesInitialState());

  static FavoritesCubit get(context) => BlocProvider.of(context);


  Map<dynamic, dynamic>? favoutiresResponse;
  FavouritesModel? favoutiresModel ;
  Future<void> fetchfav({required BuildContext context}) async {
    emit(FavoritesLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      favoutiresResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.favorite,
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      if (favoutiresResponse!['status'] == false) {
        debugPrint(favoutiresResponse.toString());
        emit(FavoritesFieldState());
      } else {
        debugPrint(favoutiresResponse.toString());
        favoutiresModel = FavouritesModel.fromJson(favoutiresResponse!);
        emit(FavoritesSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }


  Map<dynamic, dynamic>? toggleFavResponse;
  AddFavModel? toggleFavModel ;
  Future<void> toggleFav({required BuildContext context,required int id}) async {
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
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.toggleFav+ id.toString(),
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      if (toggleFavResponse!['status'] == false) {
        debugPrint(toggleFavResponse.toString());
        emit(RemoveFavoritesFieldState());
      } else {
        debugPrint(toggleFavResponse.toString());
        toggleFavModel = AddFavModel.fromJson(toggleFavResponse!);
        favoutiresModel!.data!.removeWhere((element) => element.id == id);
        emit(RemoveFavoritesSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }
}