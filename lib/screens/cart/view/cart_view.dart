import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_button.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/components/style/size.dart';
import 'package:taswqly/screens/cart/components/item_cart.dart';
import 'package:taswqly/screens/payment_type/view/payment_type_view.dart';
import '../../../components/custom_loading.dart';
import '../../../components/style/colors.dart';
import '../../../generated/locale_keys.g.dart';
import '../controller/cart_cubit.dart';
import '../controller/cart_states.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..fetchCart(context: context),
      child: BlocBuilder<CartCubit, CartStates>(builder: (context, state) {
        final cubit = CartCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: EdgeInsetsDirectional.only(start: width(context) * 0.03,end: width(context) * 0.03,top: height(context) * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: CustomText(
                          text: LocaleKeys.Cart.tr(),
                          color: AppColors.textColor,
                          fontSize: AppFonts.t2)),
                  SizedBox(height: height(context) * 0.02),
                  state is CartLoadingState?
                  const Expanded(

                      child:  CustomLoading()):
                      cubit.cartModel!.data==null?
                      Expanded(
                          child: SizedBox(
                            width:double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: LocaleKeys.EmptyCart.tr(),
                                  fontSize: AppFonts.t1,
                                  color: AppColors.textOrange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          )):
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Dismissible(
                                key: Key(cubit.cartModel!.data!.items![index].toString()),
                                confirmDismiss: (x )async{
                                  await cubit.deleteItem(context: context, id: cubit.cartModel!.data!.items![index].cartId!);
                                },
                                child: ItemCart(
                                  cubit: cubit,
                                    image: cubit.cartModel!.data!.items![index].photo!,
                                    text: cubit.cartModel!.data!.items![index].name!,
                                    sale: cubit.cartModel!.data!.items![index].price!.toString(),
                                  count: cubit.cartModel!.data!.items![index].qty.toString(),
                                  totalPc: cubit.cartModel!.data!.items![index].total.toString(),
                                  index: index,
                                  id: cubit.cartModel!.data!.items![index].cartId!,
                                ),
                              ),
                              separatorBuilder: (context, index) => SizedBox(height: height(context) * 0.02),
                              itemCount: cubit.cartModel!.data!.items!.length),
                          SizedBox(height: height(context) * 0.06),
                          Row(
                            children: [
                              CustomText(text: LocaleKeys.TotalAmount.tr(),color: AppColors.textColor,fontSize: AppFonts.t5),
                              SizedBox(width: width(context)*0.015),
                              CustomText(text: "${cubit.cartModel!.data!.total} ${LocaleKeys.Rs.tr()}",color: AppColors.greyText,fontSize: AppFonts.t5),
                            ],
                          ),
                          SizedBox(height: height(context) * 0.06),
                          CustomButton(
                              text: LocaleKeys.OrderCheckout.tr(),
                              onPressed: ()async{
                                navigateTo(context: context, widget:  PaymentTypeScreen(total:cubit.cartModel!.data!.total!));
                                // await MyFatoorah.startPayment(
                                //     context: context,
                                //     afterPaymentBehaviour: AfterPaymentBehaviour.AfterCallbackExecution,
                                //     errorChild: Center(
                                //       child: CustomText(
                                //           text: LocaleKeys.OperationField.tr(),
                                //           fontSize: AppFonts.t4,
                                //           textAlign: TextAlign.center,
                                //           fontWeight: FontWeight.bold
                                //       ),
                                //     ),
                                //     request: MyfatoorahRequest.test(
                                //       currencyIso: Country.SaudiArabia,
                                //       successUrl: 'https://openjournalsystem.com/file/2017/07/payment-success.png',
                                //       errorUrl: 'https://www.google.com/',
                                //       invoiceAmount: double.parse(cubit.cartModel!.data!.total!),
                                //       language: CacheHelper.getData(key: AppCached.appLanguage)=="ar"? ApiLanguage.Arabic : ApiLanguage.English,
                                //       token: 'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
                                //     )).then((value) async {
                                //   if(value.isSuccess){
                                //     await cubit.finishOrder(context: context);
                                //     print("succcccccccccccccccessssssssssssssssssssss");
                                //   }else if (value.isError){
                                //     showToast(text: LocaleKeys.OperationField.tr(), state: ToastStates.error);
                                //     print("errrrrrrrrrror");
                                //   }
                                // });
                              },
                              isOrange: false),
                          SizedBox(height: height(context) * 0.02)
                        ],
                      ),
                    )
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
