import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/core/local/global_config.dart';
import 'package:taswqly/screens/orders/controller/orders_states.dart';
import 'package:taswqly/screens/orders/model/orders_model.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import 'package:taswqly/shared/remote/dio.dart';

import '../../../generated/locale_keys.g.dart';

class OrdersCubit extends Cubit<OrdersStates> {
  OrdersCubit() : super(OrdersInitialState());

  static OrdersCubit get(context) => BlocProvider.of(context);


  List<String> names = [
    LocaleKeys.Current.tr(),
    LocaleKeys.Previous.tr()
  ];

  int currentIndex = 0;

  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomState());
  }

  Map<dynamic, dynamic>? ordersResponse;
  OrdersModel? ordersModel ;
  Future<void> fetchOrders({required BuildContext context}) async {
    emit(OrdersLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.userToken)}'
      };
      print(CacheHelper.getData(key: AppCached.userToken));
      ordersResponse = await myDio(
        appLanguage: CacheHelper.getData(key: AppCached.appLanguage)??"ar",
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.orders,
        methodType: 'get',
        dioBody: null,
        context: context,
      );

      if (ordersResponse!['status'] == false) {
        debugPrint(ordersResponse.toString());
        emit(OrdersFieldState());
      } else {
        debugPrint(ordersResponse.toString());
        ordersModel = OrdersModel.fromJson(ordersResponse!);
        emit(OrdersSuccessState());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }
}