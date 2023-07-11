
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../components/custom_text.dart';
import '../../../../components/style/colors.dart';
import '../../../../components/style/size.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../components/navigation.dart';

class CustomBottomSheet extends StatelessWidget {
  final Function() onPressedCamera;
  final Function() onPressedGallery;

  const CustomBottomSheet({super.key, required this.onPressedCamera, required this.onPressedGallery});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
        padding:  EdgeInsets.symmetric(horizontal: width(context)*0.01,vertical: height(context)*0.01),
        child: Column(
        children: [
          SizedBox(height: height(context)*0.015),
          GestureDetector(
            onTap:onPressedGallery,
            child: Container(
              padding: EdgeInsets.symmetric(vertical:width(context)*0.03),
              child:  Center(
                child: CustomText(
                  text: LocaleKeys.FromGallery.tr(),
                  color: AppColors.textColor,
                  fontSize: AppFonts.t6
                )
              )
            ),
          ),
          const Divider(thickness: 1.5),
          SizedBox(height: height(context)*0.01),
          GestureDetector(
            onTap:onPressedCamera,
            child: Container(
              padding: EdgeInsets.symmetric(vertical:width(context)*0.03),
              child:  Center(
                child: CustomText(
                  text: LocaleKeys.FromCamera.tr(),
                  color: AppColors.textColor,
                  fontSize: AppFonts.t6
                )
              )
            ),
          ),
          const Divider(thickness: 1.5),
          SizedBox(height: height(context)*0.01),
          GestureDetector(
            onTap:(){
              navigatorPop(context: context);
            },
            child: Container(
              padding: EdgeInsetsDirectional.only(top:width(context)*0.03),
              child:  Center(
                child: CustomText(
                  text: LocaleKeys.Cancel.tr(),
                  color: Colors.red,
                  fontSize: AppFonts.t6
                )
              )
            ),
          ),
          SizedBox(height: height(context)*0.02)
        ]
      )
    );
  }
}