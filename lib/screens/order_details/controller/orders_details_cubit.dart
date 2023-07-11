import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/core/local/global_config.dart';
import 'package:taswqly/screens/order_details/controller/orders_details_states.dart';
import 'package:taswqly/screens/order_details/model/orderDetails_model.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import 'package:taswqly/shared/remote/dio.dart';

class OrdersDetailsCubit extends Cubit<OrdersDetailsStates> {
  OrdersDetailsCubit() : super(OrdersDetailsInitialState());

  static OrdersDetailsCubit get(context) => BlocProvider.of(context);


  Map<dynamic, dynamic>? orderDetailsResponse;
  OrderDetailsModel? orderDetailsModel ;
  Future<void> fetchOrdDetails({required BuildContext context, required int id}) async {
    emit(OrderDetailsLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage),
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };
      print(CacheHelper.getData(key: AppCached.userToken));
      orderDetailsResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage),
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.ordDetails+id.toString(),
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      if (orderDetailsResponse!['status'] == false) {
        debugPrint(orderDetailsResponse.toString());
        emit(OrderDetailsFieldState());
      } else {
        debugPrint(orderDetailsResponse.toString());
        orderDetailsModel = OrderDetailsModel.fromJson(orderDetailsResponse!);
        emit(OrderDetailsSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }
}