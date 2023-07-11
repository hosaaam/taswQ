import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
import 'package:taswqly/components/custom_loading.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/custom_toast.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/components/style/colors.dart';
import 'package:taswqly/components/style/images.dart';
import 'package:taswqly/components/style/size.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/generated/locale_keys.g.dart';
import 'package:taswqly/screens/payment_type/controller/payment_type_cubit.dart';
import 'package:taswqly/screens/payment_type/controller/payment_type_states.dart';
import 'package:taswqly/shared/local/cache_helper.dart';

class PaymentTypeScreen extends StatelessWidget {
  final String total ;
  const PaymentTypeScreen({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentTypeCubit(),
      child: BlocBuilder<PaymentTypeCubit, PaymentTypeStates>(
          builder: (context, state) {
        final cubit = PaymentTypeCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width(context) * 0.03,
                  vertical: height(context) * 0.02),
              child: Column(children: [
                Row(children: [
                  GestureDetector(
                      onTap: () {
                        navigatorPop(context: context);
                      },
                      child: Image.asset(
                          context.locale.languageCode == "ar"
                              ? AppImages.arrowAR
                              : AppImages.arrowEN,
                          scale: 3.7)),
                  const Spacer(flex: 3),
                  CustomText(
                      text: LocaleKeys.PaymentType.tr(),
                      color: AppColors.textColor,
                      fontSize: AppFonts.t2),
                  const Spacer(flex: 4),
                ]),
                SizedBox(height: height(context) * 0.07),
                Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                         padding: EdgeInsets.symmetric(horizontal: width(context)*0.035),
                        itemBuilder: (context, index) {
                        if(index==0){
                          return state is PayLoadingOnlineState ? const CustomLoading():GestureDetector(
                            onTap: ()async{
                              if(index==0){
                                await MyFatoorah.startPayment(
                                    context: context,
                                    afterPaymentBehaviour: AfterPaymentBehaviour.AfterCallbackExecution,
                                    errorChild: Center(
                                      child: CustomText(
                                          text: LocaleKeys.OperationField.tr(),
                                          fontSize: AppFonts.t4,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    request: MyfatoorahRequest.test(
                                      currencyIso: Country.SaudiArabia,
                                      successUrl: 'https://openjournalsystem.com/file/2017/07/payment-success.png',
                                      errorUrl: 'https://www.google.com/',
                                      invoiceAmount: double.parse(total),
                                      language: CacheHelper.getData(key: AppCached.appLanguage)=="ar"? ApiLanguage.Arabic : ApiLanguage.English,
                                      token: 'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
                                    )).then((value) async {
                                  if(value.isSuccess){
                                    await cubit.finishOrder(context: context,type: 0);
                                    print("succcccccccccccccccessssssssssssssssssssss");
                                  }else if (value.isError){
                                    showToast(text: LocaleKeys.OperationField.tr(), state: ToastStates.error);
                                    print("errrrrrrrrrror");
                                  }
                                });

                              }else{
                                await cubit.finishOrder(context: context, type: 1);
                              }
                            },
                            child: DottedBorder(
                                color: AppColors.orangeColor,
                                strokeWidth: 2,
                                radius: const Radius.circular(7),
                                dashPattern: const [7, 5],
                                customPath: (size) {
                                  return Path()
                                    ..moveTo(7, 0)
                                    ..lineTo(size.width - 7, 0)
                                    ..arcToPoint(Offset(size.width, 7),
                                        radius: const Radius.circular(7))
                                    ..lineTo(size.width, size.height - 7)
                                    ..arcToPoint(
                                        Offset(size.width - 7, size.height),
                                        radius: const Radius.circular(7))
                                    ..lineTo(7, size.height)
                                    ..arcToPoint(Offset(0, size.height - 7),
                                        radius: const Radius.circular(7))
                                    ..lineTo(0, 7)
                                    ..arcToPoint(const Offset(7, 0),
                                        radius: const Radius.circular(7));
                                },
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.notificationColor, borderRadius: BorderRadius.circular(7)),
                                    width: width(context),
                                    padding: EdgeInsets.symmetric(
                                        vertical: height(context) * 0.035,
                                        horizontal: width(context) * 0.04),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(cubit.images[index],scale: index == 0 ? 4 : 12),
                                        SizedBox(width: width(context)*0.015),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              text: cubit.titles[index],
                                              color: AppColors.orangeColor,
                                              fontSize: AppFonts.t4,
                                            ),
                                            SizedBox(height: height(context)*0.01),
                                            SizedBox(
                                              width: index == 0?width(context)*0.63:width(context)*0.62,
                                              child: CustomText(
                                                text: cubit.subTitles[index],
                                                color: AppColors.greyRate,
                                                fontSize: AppFonts.t7,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ) ;
                        }else{
                          return state is PayLoadingState ? const CustomLoading():GestureDetector(
                            onTap: ()async{
                              if(index==0){
                                await MyFatoorah.startPayment(
                                    context: context,
                                    afterPaymentBehaviour: AfterPaymentBehaviour.AfterCallbackExecution,
                                    errorChild: Center(
                                      child: CustomText(
                                          text: LocaleKeys.OperationField.tr(),
                                          fontSize: AppFonts.t4,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    request: MyfatoorahRequest.test(
                                      currencyIso: Country.SaudiArabia,
                                      successUrl: 'https://openjournalsystem.com/file/2017/07/payment-success.png',
                                      errorUrl: 'https://www.google.com/',
                                      invoiceAmount: double.parse(total),
                                      language: CacheHelper.getData(key: AppCached.appLanguage)=="ar"? ApiLanguage.Arabic : ApiLanguage.English,
                                      token: 'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
                                    )).then((value) async {
                                  if(value.isSuccess){
                                    await cubit.finishOrder(context: context,type: 0);
                                    print("succcccccccccccccccessssssssssssssssssssss");
                                  }else if (value.isError){
                                    showToast(text: LocaleKeys.OperationField.tr(), state: ToastStates.error);
                                    print("errrrrrrrrrror");
                                  }
                                });

                              }else{
                                await cubit.finishOrder(context: context, type: 1);
                              }
                            },
                            child: DottedBorder(
                                color: AppColors.orangeColor,
                                strokeWidth: 2,
                                radius: const Radius.circular(7),
                                dashPattern: const [7, 5],
                                customPath: (size) {
                                  return Path()
                                    ..moveTo(7, 0)
                                    ..lineTo(size.width - 7, 0)
                                    ..arcToPoint(Offset(size.width, 7),
                                        radius: const Radius.circular(7))
                                    ..lineTo(size.width, size.height - 7)
                                    ..arcToPoint(
                                        Offset(size.width - 7, size.height),
                                        radius: const Radius.circular(7))
                                    ..lineTo(7, size.height)
                                    ..arcToPoint(Offset(0, size.height - 7),
                                        radius: const Radius.circular(7))
                                    ..lineTo(0, 7)
                                    ..arcToPoint(const Offset(7, 0),
                                        radius: const Radius.circular(7));
                                },
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.notificationColor, borderRadius: BorderRadius.circular(7)),
                                    width: width(context),
                                    padding: EdgeInsets.symmetric(
                                        vertical: height(context) * 0.035,
                                        horizontal: width(context) * 0.04),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(cubit.images[index],scale: index == 0 ? 4 : 12),
                                        SizedBox(width: width(context)*0.015),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              text: cubit.titles[index],
                                              color: AppColors.orangeColor,
                                              fontSize: AppFonts.t4,
                                            ),
                                            SizedBox(height: height(context)*0.01),
                                            SizedBox(
                                              width: index == 0?width(context)*0.63:width(context)*0.62,
                                              child: CustomText(
                                                text: cubit.subTitles[index],
                                                color: AppColors.greyRate,
                                                fontSize: AppFonts.t7,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ) ;
                        }
                        },
                        separatorBuilder: (context, index) => SizedBox(height: height(context) * 0.03),
                        itemCount: cubit.images.length)),
              ]),
            ),
          ),
        );
      }),
    );
  }
}
