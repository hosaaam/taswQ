import 'package:dotted_border/dotted_border.dart';
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
import 'package:taswqly/screens/order_details/components/stack_app_bar_order_details.dart';
import 'package:taswqly/screens/order_details/controller/orders_details_cubit.dart';
import 'package:taswqly/screens/order_details/orderItem_details.dart';

import '../components/item_details.dart';
import '../controller/orders_details_states.dart';

class OrdersDetailsScreen extends StatelessWidget {
  final int id;

  const OrdersDetailsScreen({super.key,  required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersDetailsCubit()..fetchOrdDetails(context: context, id: id),
      child: BlocBuilder<OrdersDetailsCubit, OrdersDetailsStates>(
          builder: (context, state) {
        final cubit = OrdersDetailsCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: state is OrderDetailsLoadingState?
            SizedBox(
              height: height(context)*0.85,
              child: const CustomLoading()
            ):
            Stack(children: [
              const StackAppBarOrderDetails(),
               Positioned.fill(
                    top: height(context) * 0.18,
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: height(context) * 0.02),
                        decoration:  BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25)),
                            color: Colors.grey[200]),
                        child: LayoutBuilder(
                            builder: (p0, p1) => SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width(context) * 0.03,
                                    vertical: height(context) * 0.02),
                                child: Column(
                                    children: [
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
                                      ListView.separated(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) => InkWell(
                                            onTap: (){
                                              navigateTo(context: context, widget: OrderItemDetailsScreen(idx: index,id: id));
                                            },
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: width(context) * 0.05,
                                                        vertical: height(context) * 0.005),
                                                    decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(8)),
                                                    child: Center(
                                                        child: Image.network(
                                                            cubit.orderDetailsModel!.data!.items![index].photo!,
                                                            width: width(context) * 0.1,
                                                            height: height(context) * 0.1))),
                                                // ClipRRect(
                                                //   borderRadius: BorderRadius.circular(10),
                                                //   child: Image.network(
                                                //     cubit.orderDetailsModel!.data!.items![index].photo!,
                                                //     height: height(context)*0.1,width: width(context)*0.17,fit: BoxFit.fill,),
                                                // ),
                                                SizedBox(width: width(context)*0.035),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: height(context)*0.01),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: width(context)*0.52,
                                                          child: CustomText(
                                                            text: cubit.orderDetailsModel!.data!.items![index].name!,
                                                            fontSize: AppFonts.t6,
                                                            color: AppColors.textColor,
                                                            maxLines:2,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                        SizedBox(width: width(context)*0.02,),
                                                        CustomText(
                                                            text:
                                                            "${cubit.orderDetailsModel!.data!.items![index].price} ${LocaleKeys.Rs.tr()}",
                                                            fontSize: AppFonts.t4),
                                                      ],
                                                    ),
                                                    SizedBox(height: height(context)*0.02,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        CustomText(
                                                          text: "${LocaleKeys.Quantity.tr()} : ",
                                                          fontSize: AppFonts.t6,
                                                          color: AppColors.textColor,
                                                        ),
                                                        CustomText(
                                                          text: cubit.orderDetailsModel!.data!.items![index].qty.toString(),
                                                          fontSize: AppFonts.t6,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          separatorBuilder: (context, index) => Padding(
                                            padding: EdgeInsets.symmetric(horizontal: width(context)*0.05,vertical: height(context)*0.03),
                                            child: Divider(thickness: 1,),
                                          ),
                                          itemCount: cubit.orderDetailsModel!.data!.items!.length),
                                      SizedBox(height: height(context)*0.08),
                                      Padding(
                                        padding:  EdgeInsetsDirectional.only(bottom: height(context)*0.015),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: width(context)*0.035,vertical: height(context)*0.02),
                                          decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              borderRadius: BorderRadius.circular(8)
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomText(text: LocaleKeys.TotalAmount.tr(),color:  AppColors.textColor,fontSize: AppFonts.t5),
                                              SizedBox(width: width(context)*0.005),
                                              Expanded(child: CustomText(text: "${cubit.orderDetailsModel!.data!.total!} ${LocaleKeys.Rs.tr()}",color:  AppColors.greyText,fontSize: AppFonts.t6)),

                                            ],
                                          ),

                                        ),
                                      ),
                                    ]),
                              ),
                            ))),
                  ),

            ]),
          ),
        );
      }),
    );
  }
}
