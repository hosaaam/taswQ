import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/style/colors.dart';
import 'package:taswqly/components/style/images.dart';
import 'package:taswqly/components/style/size.dart';

class MoreItem extends StatelessWidget {
  final String text ;
  final Function() onTap ;
  final bool? isNotify ;
  final Widget? widget ;
  const MoreItem({Key? key, required this.text, required this.onTap,  this.isNotify=false, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsetsDirectional.only(bottom: height(context)*0.015),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width(context)*0.03,vertical: height(context)*0.02),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8)
          ),
          child:Row(
            children: [
              CustomText(text: text,color: AppColors.textColor,fontSize: AppFonts.t6),
              const Spacer(),
              isNotify==false?Image.asset(context.locale.languageCode == "ar"?AppImages.arrowLeftAr:AppImages.arrowLeftEn,scale: 3):widget!,
              isNotify==false?SizedBox(width: width(context)*0.025):const SizedBox.shrink()
            ],
          ) ,
        ),
      ),
    );
  }
}
