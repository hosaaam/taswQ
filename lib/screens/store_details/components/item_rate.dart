import 'package:flutter/material.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/style/size.dart';
import 'package:taswqly/screens/home/components/rating_bar.dart';

import '../../../components/style/colors.dart';

class ItemRate extends StatelessWidget {
  final String name ;
  final String image ;
  final String comment ;
  final String date ;
  final double rate ;
  const ItemRate({Key? key, required this.name, required this.image, required this.comment, required this.date, required this.rate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      decoration: BoxDecoration(
        color: AppColors.shadowBlue,
        borderRadius: BorderRadius.circular(8)

      ),
      padding: EdgeInsets.symmetric(horizontal: width(context)*0.03,vertical: height(context)*0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(image),
                backgroundColor: AppColors.shadowBlue,
                radius: 30
              ),
              // SizedBox(width: width(context)*0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: name,
                      color: AppColors.textColor,
                      fontSize: AppFonts.t5),
                  SizedBox(height: height(context)*0.01),
                  RatingBarItem(rate: rate),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  CustomText(text: date,color: AppColors.textColor, fontSize: AppFonts.t7),
                  SizedBox(height: height(context)*0.035),
                ],
              ),
            ],
          ),
          SizedBox(height: height(context)*0.025),
          CustomText(
              text: comment,
              color: AppColors.greyRate,
              fontSize: AppFonts.t6),
        ],
      ),
    );
  }
}
