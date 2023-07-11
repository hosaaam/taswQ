import 'package:flutter/material.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/components/style/size.dart';
import 'package:taswqly/screens/home/components/rating_bar.dart';
import 'package:taswqly/screens/store_details/view/store_details_view.dart';

import '../../../components/style/colors.dart';
import '../../../components/style/images.dart';

class ItemGrid extends StatelessWidget {
  final String image;
  final int storeId;
  final String text;
  final String textTime;
  final double rate;

  ItemGrid({required this.image,required this.rate,required this.storeId, required this.text, required this.textTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
        start: width(context) * 0.03,
          bottom:height(context) * 0.02 ,
          top: height(context) * 0.02),
      decoration: BoxDecoration(
          color: AppColors.whiteColor, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(image, height: height(context) * 0.1,fit: BoxFit.fill,width: width(context)*0.4,),
          SizedBox(height: height(context) * 0.02),
          CustomText(
              text: text,
              color: AppColors.textColor,
              fontSize: AppFonts.t7,
              maxLines: 2,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis),
          SizedBox(height: height(context) * 0.01),
          RatingBarItem(rate: rate),
          SizedBox(height: height(context) * 0.015),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Image.asset(AppImages.clock, scale: 4),
          //     SizedBox(width: width(context)*0.01),
          //     CustomText(text: textTime,color: AppColors.greyText,fontSize: AppFonts.t8)
          //   ],
          // ),
        ],
      ),
    );
  }
}
