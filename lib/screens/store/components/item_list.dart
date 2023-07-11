import 'package:flutter/cupertino.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/style/colors.dart';
import 'package:taswqly/components/style/size.dart';

import '../../../components/style/images.dart';

class ItemFilterList extends StatelessWidget {
  final String text ;
  const ItemFilterList({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width(context)*0.02,vertical: height(context)*0.015),
      decoration: BoxDecoration(
        color: AppColors.shadowBlue,
        borderRadius: BorderRadius.circular(6)
      ),
      child: Row(
        children: [
          CustomText(text: text,color: AppColors.blackColor,fontSize: AppFonts.t7),
          SizedBox(width: width(context)*0.03),
          GestureDetector(
            onTap: (){},
            child: Image.asset(AppImages.delete,scale: 4)
          )
        ]
      )
    );
  }
}
