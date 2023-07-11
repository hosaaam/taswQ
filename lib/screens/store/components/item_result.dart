import 'package:flutter/material.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/components/style/size.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/screens/home/components/rating_bar.dart';
import 'package:taswqly/screens/store_details/view/store_details_view.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import '../../../components/style/colors.dart';
import '../../../components/style/images.dart';

class ItemResultSearch extends StatelessWidget {
  final String image;

  final String text;

  final String subTitle;

  // final String textTime;

  final double rate;

  final bool? isFav;

  final Function()? onFav;

  final int storeId;

  const ItemResultSearch({ required this.image, required this.storeId, required this.text,
    required this.subTitle, required this.rate, required this.onFav, required this.isFav});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: width(context) * 0.03,
            vertical: height(context) * 0.02),
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.network(image,
                  fit: BoxFit.fill, width: width(context) * 0.2)),
          SizedBox(width: width(context) * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: width(context) * 0.5,
                  child: CustomText(
                      text: text,
                      color: AppColors.textColor,
                      fontSize: AppFonts.t6,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2)),
              SizedBox(height: height(context) * 0.01),
              SizedBox(
                  width: width(context) * 0.5,
                  child: CustomText(
                      text: subTitle,
                      color: AppColors.greyText,
                      fontSize: AppFonts.t8,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2)),
              SizedBox(height: height(context) * 0.01),
              RatingBarItem(rate: rate),
              SizedBox(height: height(context) * 0.01),
              // Row(
              //   children: [
              //     Image.asset(AppImages.clock, scale: 4),
              //     SizedBox(width: width(context) * 0.01),
              //     CustomText(
              //         text: textTime,
              //         color: AppColors.greyText,
              //         fontSize: AppFonts.t9)
              //   ]
              // )
            ]
          ),
          const Spacer(),
              CacheHelper.getData(key: AppCached.userToken)!=null ?GestureDetector(
              onTap: onFav,
              child:
              isFav==true?
              const Icon(Icons.favorite, color: Colors.red):
              const Icon(Icons.favorite_border)
          ):const SizedBox.shrink(),
        ]));
  }
}
