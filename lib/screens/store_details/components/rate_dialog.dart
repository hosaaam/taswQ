import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:taswqly/components/custom_button.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/components/style/colors.dart';
import 'package:taswqly/components/style/images.dart';
import 'package:taswqly/components/style/size.dart';
import 'package:taswqly/generated/locale_keys.g.dart';

class RateDialog extends StatelessWidget {
  final Function(double)? onRatingChanged;
  final Function() onPressed;

  final double rate;

  final TextEditingController commentCtrl;

  const RateDialog(
      {Key? key,
      this.onRatingChanged,
      required this.commentCtrl,
      required this.rate, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyText.withOpacity(0.0005),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: width(context) * 0.05),
          decoration: BoxDecoration(
              color: AppColors.whiteColor.withOpacity(0.955),
              borderRadius: BorderRadius.circular(15)),
          padding: EdgeInsets.symmetric(
              horizontal: width(context) * 0.04,
              vertical: height(context) * 0.02),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Spacer(flex: 4),
                    CustomText(
                        text: LocaleKeys.StoreRating.tr(),
                        color: AppColors.textColor,
                        fontSize: AppFonts.t3),
                    const Spacer(flex: 3),
                    GestureDetector(
                      onTap: () {
                        navigatorPop(context: context);
                      },
                      child: Image.asset(AppImages.close, scale: 3),
                    ),
                  ],
                ),
                SizedBox(height: height(context) * 0.03),
                SmoothStarRating(
                    allowHalfRating: false,
                    onRatingChanged: onRatingChanged,
                    starCount: 5,
                    rating: rate,
                    size: 40.0,
                    color: AppColors.textColor,
                    borderColor: AppColors.textColor,
                    spacing: 0.0),
                SizedBox(height: height(context) * 0.045),
                TextFormField(
                  autocorrect: true,
                  maxLines: 4,
                  controller: commentCtrl,
                  decoration: InputDecoration(
                    hintText: "${LocaleKeys.AddAComment.tr()} ...",
                    prefixIcon: Padding(
                      padding: EdgeInsetsDirectional.only(start: width(context)*0.001, bottom: height(context)*0.095),
                      child: Image.asset(AppImages.comment, scale: 3.3),
                    ),
                    hintStyle: const TextStyle(color: AppColors.greyText),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: height(context) * 0.02),
                CustomButton(text: LocaleKeys.Confirm.tr(), onPressed: onPressed, isOrange: false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
