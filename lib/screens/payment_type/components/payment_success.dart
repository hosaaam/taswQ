import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taswqly/components/custom_button.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/components/style/colors.dart';
import 'package:taswqly/components/style/images.dart';
import 'package:taswqly/components/style/size.dart';
import 'package:taswqly/generated/locale_keys.g.dart';
import 'package:taswqly/screens/btnNavBar/view/btn_nav_bar_view.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width(context) * 0.03,
              vertical: height(context) * 0.02),
          child: Column(
            children: [
              SizedBox(height: height(context)*0.12),
              Expanded(child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(AppImages.successPay,scale: 3),
                    SizedBox(height: height(context)*0.06),
                    CustomText(
                      text: LocaleKeys.PaymentSuccessfullyPaid.tr(),
                      color: AppColors.orangeColor,
                      fontSize: AppFonts.t1,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center
                    ),
                    SizedBox(height: height(context)*0.08),
                    CustomButton(text: LocaleKeys.BackToHome.tr(), onPressed: (){
                      navigateAndFinish(context: context, widget: const BottomNavBar());
                    }, isOrange: false),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
