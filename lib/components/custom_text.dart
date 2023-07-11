import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final double? wordSpacing;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextDecoration? decoration;
  const CustomText({Key? key, required this.text, this.color, this.fontSize, this.wordSpacing, this.textAlign, this.fontWeight, this.overflow, this.maxLines, this.decoration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: decoration,
          wordSpacing: wordSpacing,
        ),
        overflow: overflow,
        maxLines: maxLines);
  }
}
