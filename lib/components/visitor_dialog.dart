import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taswqly/components/custom_button.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/components/style/colors.dart';
import 'package:taswqly/components/style/size.dart';
import 'package:taswqly/generated/locale_keys.g.dart';
import 'package:taswqly/screens/auth/login/view/login_view.dart';


class VisitorDialog extends StatelessWidget {
  const VisitorDialog({super.key});


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      title: CustomText(
          text: LocaleKeys.CannotAccessContent.tr(),
          fontWeight: FontWeight.bold,
          fontSize: AppFonts.t5,
          color: AppColors.orangeColor,
          textAlign: TextAlign.center),
      contentPadding: EdgeInsetsDirectional.only(bottom: height(context)*0.02,top: height(context)*0.04,end:width(context)*0.05,start: width(context)*0.05 ),
      content: SizedBox(
        child: CustomButton(
          isOrange: false,
            onPressed: () {
              navigateAndFinish(
                  context: context, widget: const LoginScreen());
            },
            text: LocaleKeys.Login.tr()),
      ),
    );
  }
}