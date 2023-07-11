import 'package:flutter/material.dart';
import 'package:taswqly/components/style/colors.dart';
import 'custom_text.dart';
import 'style/size.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool isOrange;
  final double? fontSize;

  const CustomButton({
    Key? key,
    required this.text,
    this.fontSize,
    required this.onPressed,
    required this.isOrange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height(context) * 0.078,
        decoration: isOrange == false
            ? const BoxDecoration(
                color: AppColors.bottomColor,
                borderRadius:  BorderRadius.all(Radius.circular(5))
               )
            : const BoxDecoration(
                color: AppColors.orangeColor,
                borderRadius:  BorderRadius.all(Radius.circular(5))
                ),
        child: Center(
            child: CustomText(
                text: text,
                color: AppColors.whiteColor,
                fontSize: fontSize ?? AppFonts.t4)),
      ),
    );
  }
}
