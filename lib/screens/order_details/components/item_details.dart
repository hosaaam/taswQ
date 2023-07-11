import 'package:flutter/material.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/style/size.dart';

import '../../../components/style/colors.dart';

class ItemDetails extends StatelessWidget {
  final String title ;
  final String subTitle ;
  const ItemDetails({Key? key, required this.title, required this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            CustomText(text: "$title : ",color:  AppColors.textColor,fontSize: AppFonts.t5),
            SizedBox(width: width(context)*0.005),
            Expanded(child: CustomText(text: subTitle,color:  AppColors.greyText,fontSize: AppFonts.t6)),

          ],
        ),

      ),
    );
  }
}
