import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_button.dart';
import 'package:taswqly/components/custom_loading.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/components/style/colors.dart';
import 'package:taswqly/components/style/images.dart';
import 'package:taswqly/components/style/size.dart';
import 'package:taswqly/generated/locale_keys.g.dart';
import 'package:taswqly/screens/scan/view/scanQr_code.dart';
import 'package:taswqly/screens/order_details/components/item_details.dart';
import 'package:taswqly/screens/product_details/components/stack_app_bar_product_details.dart';
import 'package:taswqly/screens/product_details/controller/product_details_cubit.dart';
import 'package:taswqly/screens/product_details/controller/product_details_states.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String? id;

  const ProductDetailsScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit()..fetchProductDetails(context: context, id: id!),
      child: BlocBuilder<ProductDetailsCubit, ProductDetailsStates>(
          builder: (context, state) {
            final cubit = ProductDetailsCubit.get(context);
            return SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child:
                  state is ProdDetailsLoadingState?
                    SizedBox(height: height(context)*0.8,
                       child: CustomLoading(),):
                      cubit.productDetailsModel!.data==null?
                          Center(
                            child: Column(
                              children: [
                                SizedBox(height: height(context)*0.4),
                                // Image.asset(AppImages.productMark,scale: 3),
                                SizedBox(height: height(context)*0.02),
                                CustomText(text: LocaleKeys.ProdUnAvailable.tr(),color: AppColors.textColor,fontSize: AppFonts.h2),
                              ],
                            ),
                          ):
                  Column(
                    children: [
                      StackAppBarProductDetails(cubit:cubit),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width(context) * 0.03,
                            vertical: height(context) * 0.02),
                        child: Column(
                          children: [
                            SizedBox(height: height(context)*0.02),
                            Image.asset(AppImages.productMark,scale: 3),
                            SizedBox(height: height(context)*0.02),
                            CustomText(text: LocaleKeys.ProductAvailable.tr(),color: AppColors.textColor,fontSize: AppFonts.h3),
                            SizedBox(height: height(context)*0.035),
                            ItemDetails(title: LocaleKeys.ProductName.tr(),subTitle: cubit.productDetailsModel!.data!.name!),
                            ItemDetails(title: LocaleKeys.Price.tr(),subTitle: "${cubit.productDetailsModel!.data!.price!} ${LocaleKeys.Rs.tr()}"),
                            // ItemDetails(title: LocaleKeys.description.tr(),subTitle: "مكرونة بالصلصة مكرونة بالصلصة مكرونة بالصلصة مكرونة بالصلصة"),
                            SizedBox(height: height(context)*0.03),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(text: "${LocaleKeys.QuantitySelection.tr()} : ",color:  AppColors.textColor,fontSize: AppFonts.t5),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                          onTap: (){
                                            cubit.plus();
                                          },
                                          child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: width(context)*0.022,vertical: height(context)*0.01),
                                              decoration: BoxDecoration(
                                                  color: AppColors.shadowBlue,
                                                  borderRadius: BorderRadius.circular(20)
                                              ),
                                              child: Center(
                                                  child: Image.asset(AppImages.add,scale: 3.5)
                                              )
                                          )
                                      ),
                                      SizedBox(width: width(context)*0.035),
                                      CustomText(text: cubit.counter.toString(),color: AppColors.greyText,fontSize: AppFonts.t4),
                                      SizedBox(width: width(context)*0.035),
                                      GestureDetector(
                                          onTap: (){
                                            cubit.minus();
                                          },
                                          child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: width(context)*0.022,vertical: height(context)*0.017),
                                              decoration: BoxDecoration(
                                                  color: AppColors.shadowBlue,
                                                  borderRadius: BorderRadius.circular(20)
                                              ),
                                              child: Center(
                                                child: Image.asset(AppImages.minus,scale: 3.3),
                                              )
                                          )
                                      )
                                    ]
                                ),
                              ],
                            ),
                            SizedBox(height: height(context) * 0.04),
                            state is AddToCartLoadingState?
                            const CustomLoading():
                            CustomButton(
                                text: LocaleKeys.AddToCart.tr(),
                                onPressed: (){
                                  cubit.addToCart(context: context, id: cubit.productDetailsModel!.data!.id!);
                                  },
                                isOrange: false),
                            SizedBox(height: height(context) * 0.02)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
