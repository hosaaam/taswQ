import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_loading.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/style/colors.dart';
import 'package:taswqly/components/style/size.dart';
import 'package:taswqly/generated/locale_keys.g.dart';
import 'package:taswqly/screens/order_details/components/item_details.dart';
import 'package:taswqly/screens/order_details/components/stack_app_bar_order_details.dart';
import 'package:taswqly/screens/order_details/components/stack_item_app_bar_details.dart';
import 'package:taswqly/screens/order_details/controller/orders_details_cubit.dart';
import 'package:taswqly/screens/order_details/controller/orders_details_states.dart';


class OrderItemDetailsScreen extends StatelessWidget {
  final int idx;
  final int id;

  const OrderItemDetailsScreen({super.key,  required this.idx, required this.id,});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersDetailsCubit()..fetchOrdDetails(context: context, id: id),
      child: BlocBuilder<OrdersDetailsCubit, OrdersDetailsStates>(
          builder: (context, state) {
            final cubit = OrdersDetailsCubit.get(context);
            return SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: state is OrderDetailsLoadingState?
                  SizedBox(
                    height: height(context)*0.85,
                    child: const CustomLoading(),
                  ):
                  Column(
                      children: [
                     StackAppBarItemDetails(photo:cubit.orderDetailsModel!.data!.items![idx].photo!),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width(context) * 0.03,
                          vertical: height(context) * 0.02),
                      child: Column(children: [
                        SizedBox(height: height(context)*0.01),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: width(context)*0.05),
                          child: DottedBorder(
                              color: AppColors.orangeColor,
                              strokeWidth: 2,
                              radius: const Radius.circular(7),
                              dashPattern: const [7, 5],
                              customPath: (size) {
                                return Path()
                                  ..moveTo(7, 0)
                                  ..lineTo(size.width - 7, 0)
                                  ..arcToPoint(Offset(size.width, 7), radius: const Radius.circular(7))
                                  ..lineTo(size.width, size.height - 7)
                                  ..arcToPoint(Offset(size.width - 7, size.height), radius: const Radius.circular(7))
                                  ..lineTo(7, size.height)
                                  ..arcToPoint(Offset(0, size.height - 7), radius: const Radius.circular(7))
                                  ..lineTo(0, 7)
                                  ..arcToPoint(const Offset(7, 0), radius: const Radius.circular(7));
                              },
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.notificationColor,
                                      borderRadius:
                                      BorderRadius.circular(7)),
                                  width: width(context),
                                  padding:
                                  EdgeInsets.symmetric(vertical: height(context) * 0.02),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        text:
                                        "${LocaleKeys.NumberOrder.tr()} : ",
                                        color: AppColors.orangeColor,
                                        fontSize: AppFonts.t4,
                                      ),
                                      CustomText(
                                        text: cubit.orderDetailsModel!.data!.numOrd!,
                                        color: AppColors.greyText,
                                        fontSize: AppFonts.t4,
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        SizedBox(height: height(context)*0.05),
                        ItemDetails(title: LocaleKeys.ProductName.tr(),subTitle: cubit.orderDetailsModel!.data!.items![idx].name!),
                        // ItemDetails(title: LocaleKeys.StoreName.tr(),subTitle: "متجر مملكة الرياض"),
                        ItemDetails(title: LocaleKeys.DateOrder.tr(),subTitle: cubit.orderDetailsModel!.data!.date!),
                        ItemDetails(title: LocaleKeys.Quantity.tr(),subTitle: cubit.orderDetailsModel!.data!.items![idx].qty!.toString()),
                        // ItemDetails(title: LocaleKeys.ingredients.tr(),subTitle: "مكرونة بالصلصة مكرونة بالصلصة مكرونة بالصلصة مكرونة بالصلصة"),
                        // ItemDetails(title: LocaleKeys.description.tr(),subTitle: "مكرونة بالصلصة مكرونة بالصلصة مكرونة بالصلصة مكرونة بالصلصة"),
                      ]),
                    ),
                  ]),
                ),
              ),
            );
          }),
    );
  }
}
