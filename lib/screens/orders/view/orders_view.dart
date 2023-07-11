import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_loading.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/components/style/colors.dart';
import 'package:taswqly/components/style/images.dart';
import 'package:taswqly/components/style/size.dart';
import 'package:taswqly/generated/locale_keys.g.dart';
import 'package:taswqly/screens/order_details/view/orders_details_view.dart';
import 'package:taswqly/screens/orders/components/stack_app_bar_orders.dart';
import 'package:taswqly/screens/orders/controller/orders_cubit.dart';
import 'package:taswqly/screens/orders/controller/orders_states.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersCubit()..fetchOrders(context: context),
      child: BlocBuilder<OrdersCubit, OrdersStates>(builder: (context, state) {
        final cubit = OrdersCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: Column(children: [
              StackAppBarOrders(cubit: cubit),
              state is OrdersLoadingState
                  ? const Expanded(child: CustomLoading())
                  : cubit.currentIndex == 0
                      ? cubit.ordersModel!.data!.currentOrders!.isEmpty
                          ? Expanded(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomText(
                                    text: LocaleKeys.CurrentEmpty.tr(),
                                    fontSize: AppFonts.t3,
                                    color: AppColors.textOrange,
                                    fontWeight: FontWeight.bold),
                              ],
                            ))
                          : Expanded(
                              child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width(context) * 0.05),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                        onTap: () {
                                          navigateTo(
                                              context: context,
                                              widget: OrdersDetailsScreen(id: cubit.ordersModel!.data!.currentOrders![index].id!,));
                                        },
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          width(context) * 0.05,
                                                      vertical: height(context) *
                                                          0.005),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          AppColors.whiteColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Center(
                                                      child: Image.network(
                                                          cubit
                                                              .ordersModel!
                                                              .data!
                                                              .currentOrders![
                                                                  index]
                                                              .items![0]
                                                              .photo!,
                                                          width: width(context) *
                                                              0.1,
                                                          height: height(context) * 0.1))),
                                              SizedBox(width: width(context) * 0.03),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      height: height(context) *
                                                          0.005),
                                                  // CustomText(
                                                  //     text: cubit.ordersModel!.data!.currentOrders![index].items![0].name!,
                                                  //     color: AppColors.textColor,
                                                  //     fontSize: AppFonts.t6),
                                                  // SizedBox(
                                                  //     height: height(context) * 0.01),
                                                  Row(children: [
                                                    CustomText(
                                                        text: "${LocaleKeys.NumberOrder.tr()} :",
                                                        color: AppColors.textColor,
                                                        fontSize: AppFonts.t7),
                                                    SizedBox(width: width(context) * 0.007),
                                                    CustomText(
                                                        text: cubit.ordersModel!.data!.currentOrders![index].numOrd!,
                                                        color: AppColors.greyText,
                                                        fontSize: AppFonts.t6),
                                                  ]),
                                                  SizedBox(height: height(context) * 0.01),
                                                  Row(children: [
                                                    CustomText(
                                                        text: "${LocaleKeys.DateOrder.tr()} :",
                                                        color: AppColors.textColor,
                                                        fontSize: AppFonts.t7),
                                                    SizedBox(width: width(context) * 0.007),
                                                    CustomText(
                                                        text: cubit.ordersModel!.data!.currentOrders![index].date!,
                                                        color: AppColors.greyText,
                                                        fontSize: AppFonts.t6),
                                                  ]),
                                                  SizedBox(height: height(context) * 0.01),
                                                  Row(children: [
                                                    CustomText(
                                                        text: "${LocaleKeys.Quantity.tr()} :",
                                                        color: AppColors.textColor,
                                                        fontSize: AppFonts.t7),
                                                    SizedBox(width: width(context) * 0.007),
                                                    CustomText(
                                                        text: cubit.ordersModel!.data!.currentOrders![index].countItems!.toString(),
                                                        color: AppColors.greyText,
                                                        fontSize: AppFonts.t6),
                                                  ]),
                                                ],
                                              ),
                                              // const Spacer(),
                                              // Column(
                                              //   children: [
                                              //     SizedBox(height: height(context) * 0.005),
                                              //     CustomText(
                                              //         text: "${cubit.ordersModel!.data!.currentOrders![index].total!} ${LocaleKeys.Rs.tr()}",
                                              //         fontSize: AppFonts.t4),
                                              //   ],
                                              // ),
                                            ]),
                                      ),
                                  separatorBuilder: (context, index) => Column(
                                        children: [
                                          SizedBox(
                                              height: height(context) * 0.02),
                                          Image.asset(AppImages.lineDivider,
                                              scale: 4.5),
                                          SizedBox(
                                              height: height(context) * 0.02)
                                        ],
                                      ),
                                  itemCount: cubit.ordersModel!.data!
                                      .currentOrders!.length),
                            )
                      : cubit.ordersModel!.data!.previousOrders!.isEmpty
                          ? Expanded(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomText(
                                    text: LocaleKeys.PreviousEmpty.tr(),
                                    fontSize: AppFonts.t3,
                                    color: AppColors.textOrange,
                                    fontWeight: FontWeight.bold),
                              ],
                            ))
                          : Expanded(
                              child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width(context) * 0.05),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                        onTap: () {
                                          navigateTo(
                                              context: context,
                                              widget: OrdersDetailsScreen(id: cubit.ordersModel!.data!.previousOrders![index].id!));
                                        },
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: width(context) * 0.05,
                                                      vertical: height(context) * 0.005),
                                                  decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(8)),
                                                  child: Center(
                                                      child: Image.network(
                                                          cubit.ordersModel!.data!.previousOrders![index].items![0].photo!,
                                                          width: width(context) * 0.1,
                                                          height: height(context) * 0.1))),
                                              SizedBox(width: width(context) * 0.03),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      height: height(context) *
                                                          0.005),
                                                  // CustomText(
                                                  //     text: cubit
                                                  //         .ordersModel!
                                                  //         .data!
                                                  //         .previousOrders![
                                                  //             index]
                                                  //         .items![0]
                                                  //         .name!,
                                                  //     color:
                                                  //         AppColors.textColor,
                                                  //     fontSize: AppFonts.t6),
                                                  // SizedBox(
                                                  //     height: height(context) *
                                                  //         0.01),
                                                  Row(children: [
                                                    CustomText(
                                                        text:
                                                            "${LocaleKeys.NumberOrder.tr()} :",
                                                        color:
                                                            AppColors.textColor,
                                                        fontSize: AppFonts.t7),
                                                    SizedBox(
                                                        width: width(context) *
                                                            0.007),
                                                    CustomText(
                                                        text: cubit.ordersModel!.data!.previousOrders![index].numOrd!,
                                                        color:
                                                            AppColors.greyText,
                                                        fontSize: AppFonts.t6),
                                                  ]),
                                                  SizedBox(
                                                      height: height(context) *
                                                          0.01),
                                                  Row(children: [
                                                    CustomText(
                                                        text:
                                                            "${LocaleKeys.DateOrder.tr()} :",
                                                        color:
                                                            AppColors.textColor,
                                                        fontSize: AppFonts.t7),
                                                    SizedBox(
                                                        width: width(context) *
                                                            0.007),
                                                    CustomText(
                                                        text: cubit
                                                            .ordersModel!
                                                            .data!
                                                            .previousOrders![
                                                                index]
                                                            .date!,
                                                        color:
                                                            AppColors.greyText,
                                                        fontSize: AppFonts.t6),
                                                  ]),
                                                  SizedBox(height: height(context) * 0.01),
                                                  Row(children: [
                                                    CustomText(
                                                        text: "${LocaleKeys.Quantity.tr()} :",
                                                        color: AppColors.textColor,
                                                        fontSize: AppFonts.t7),
                                                    SizedBox(width: width(context) * 0.007),
                                                    CustomText(
                                                        text: cubit.ordersModel!.data!.previousOrders![index].countItems!.toString(),
                                                        color: AppColors.greyText,
                                                        fontSize: AppFonts.t6),
                                                  ]),
                                                ],
                                              ),
                                              // const Spacer(),
                                              // Column(
                                              //   children: [
                                              //     SizedBox(
                                              //         height: height(context) *
                                              //             0.005),
                                              //     CustomText(
                                              //         text:
                                              //             "${cubit.ordersModel!.data!.previousOrders![index].total!} ${LocaleKeys.Rs.tr()}",
                                              //         fontSize: AppFonts.t4),
                                              //   ],
                                              // ),
                                            ]),
                                      ),
                                  separatorBuilder: (context, index) => Column(
                                        children: [
                                          SizedBox(
                                              height: height(context) * 0.02),
                                          Image.asset(AppImages.lineDivider,
                                              scale: 4.5),
                                          SizedBox(
                                              height: height(context) * 0.02)
                                        ],
                                      ),
                                  itemCount: cubit.ordersModel!.data!
                                      .previousOrders!.length),
                            )
            ]),
          ),
        );
      }),
    );
  }
}
