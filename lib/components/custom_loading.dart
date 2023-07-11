import 'dart:io';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:taswqly/components/style/colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: SizedBox(
        width: 40,
        height: 40,
        child: LoadingIndicator(
          pathBackgroundColor: AppColors.textColor,
          indicatorType: Platform.isAndroid?Indicator.ballSpinFadeLoader:Indicator.lineSpinFadeLoader,
        ),
      ),
    );
  }
}
