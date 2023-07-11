import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_toast.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/core/local/global_config.dart';
import 'package:taswqly/screens/store_details/controller/store_details_states.dart';
import 'package:taswqly/screens/store_details/model/addFav_model.dart';
import 'package:taswqly/screens/store_details/model/storeDetails_model.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import 'package:taswqly/shared/remote/dio.dart';

class StoreDetailsCubit extends Cubit<StoreDetailsStates> {
  StoreDetailsCubit() : super(StoreDetailsInitialState());

  static StoreDetailsCubit get(context) => BlocProvider.of(context);
  double rate = 0 ;
  final commentCtrl = TextEditingController();

  changeRate(rating){
    rate=rating;
    print(rate);
    emit(RateState());
  }

  int numSlider = 0;
  void changeSlider(int index) {
    numSlider = index;
    emit(RateState());
  }
  Map<dynamic, dynamic>? storeDetailsResponse;
  ShopDetailsModel? storeDetailsModel ;
  Future<void> fetchStoreDetails({required BuildContext context,required int id}) async {
    if(isRate==false)
    emit(StoreDetailsLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        if(CacheHelper.getData(key: AppCached.userToken)!=null)
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      storeDetailsResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.shopDetails+id.toString(),
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      if (storeDetailsResponse!['status'] == false) {
        debugPrint(storeDetailsResponse.toString());
        emit(StoreDetailsFieldState());
      } else {
        debugPrint(storeDetailsResponse.toString());
        storeDetailsModel = ShopDetailsModel.fromJson(storeDetailsResponse!);
        emit(StoreDetailsSuccessState());
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
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };

      toggleFavResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage)??"ar",
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
        storeDetailsModel!.data!.isFavorite = !storeDetailsModel!.data!.isFavorite!;
        emit(StoreDetailsSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

  Map<dynamic, dynamic>? addRateResponse;
  bool isRate=false;
  Future<void> addRate({required BuildContext context,required int id}) async {
    emit(AddRateLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };
      Map<String, dynamic> body = {
        'rate': rate,
        'shop_id': id,
        'comment': commentCtrl.text,
      };

      addRateResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.addRate,
        methodType: 'post',
        dioBody: body,
        context: context,
      );

      if (addRateResponse!['status'] == false) {
        debugPrint(addRateResponse.toString());
        showToast(text: addRateResponse!['message'], state: ToastStates.error);
        emit(StoreDetailsFieldState());
      } else {
        debugPrint(addRateResponse.toString());
        navigatorPop(context: context);
        showToast(text: addRateResponse!['message'], state: ToastStates.success);
        isRate=true;
        fetchStoreDetails(context: context, id: id);
        emit(StoreDetailsSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

  Map<dynamic, dynamic>? addReportResponse;
  TextEditingController reportCtrl = TextEditingController();
  Future<void> addReport({required BuildContext context,required int id}) async {
    emit(AddReportLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };
      Map<String, dynamic> body = {
        'shop_id': id,
        'comment': reportCtrl.text,
      };

      addReportResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.addReport,
        methodType: 'post',
        dioBody: body,
        context: context,
      );

      if (addReportResponse!['status'] == false) {
        debugPrint(addReportResponse.toString());
        showToast(text: addReportResponse!['message'], state: ToastStates.error);
        emit(StoreDetailsFieldState());
      } else {
        debugPrint(addReportResponse.toString());
        showToast(text: addReportResponse!['message'], state: ToastStates.success);
        navigatorPop(context: context);
        emit(StoreDetailsSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }
}