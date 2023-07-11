import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../components/style/colors.dart';
import '../../../components/style/size.dart';

class RatingBarItem extends StatelessWidget {
  final double rate ;
  final double? itemSize ;
  const RatingBarItem({Key? key, required this.rate, this.itemSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      tapOnlyMode: true,
      unratedColor: AppColors.starFill,
      glowRadius: 2,
      itemSize: itemSize??width(context)*0.04,
      initialRating: rate,
      ignoreGestures: true,
      minRating: 0,
      direction: Axis.horizontal,
      itemCount: 5,
      // itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
      ratingWidget: RatingWidget(
          full: const Icon(
            Icons.star,
            color: AppColors.starMark,
          ),
          empty: const Icon(
            Icons.star,
            color: AppColors.starFill,
          ),
          half: const Icon(Icons.star)),
      onRatingUpdate: (rating) {},
    );
  }
}
