import 'package:flutter/material.dart';
import 'package:taswqly/components/style/colors.dart';
import 'package:taswqly/components/style/size.dart';

class ItemClick extends StatelessWidget {
  final String image ;
  final Function() onTap;
  final EdgeInsetsGeometry? padding ;
  const ItemClick({Key? key, required this.image, this.padding, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding??EdgeInsets.symmetric(horizontal: width(context)*0.06,vertical: height(context)*0.02),
        decoration: BoxDecoration(
          color: AppColors.shadowBlue,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Center(
          child: Image.asset(image,scale: 3.7),
        ),
      ),
    );
  }
}
