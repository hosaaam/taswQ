import 'package:flutter/material.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/style/colors.dart';
import 'package:taswqly/components/style/size.dart';

class ItemList extends StatelessWidget {
  final String image ;
  final String text ;
  const ItemList({Key? key, required this.image, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width(context)*0.02,vertical: height(context)*0.01),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8)
      ),
      child:Row(
        children: [
          Image.network(image,scale: 3.5),
          SizedBox(width: width(context)*0.02),
          CustomText(text: text,fontSize: AppFonts.t8,color: AppColors.textColor)
        ],
      ) ,
    );
  }
}
