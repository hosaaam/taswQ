import 'package:flutter/material.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/style/size.dart';

import '../../../components/style/colors.dart';

class ProfileItem extends StatelessWidget {
  final String image;

  final String text;

  const ProfileItem({Key? key, required this.image, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width(context) * 0.04, vertical: height(context) * 0.02),
      decoration: BoxDecoration(
        color: AppColors.shadowBlue,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          Image.asset(image, scale: 3.5),
          SizedBox(width: width(context) * 0.03),
          SizedBox(
              width: width(context) * 0.71,
              child: CustomText(
                  text: text,
                  color: AppColors.textColor,
                  fontSize: AppFonts.t5))
        ],
      ),
    );
  }
}
