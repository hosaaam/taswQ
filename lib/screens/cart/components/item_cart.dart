import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taswqly/screens/cart/controller/cart_cubit.dart';

import '../../../components/custom_text.dart';
import '../../../components/style/colors.dart';
import '../../../components/style/images.dart';
import '../../../components/style/size.dart';
import '../../../generated/locale_keys.g.dart';

class ItemCart extends StatelessWidget {
  final String image ;
  final CartCubit cubit ;
  final String text ;
  final String sale ;
  final String count ;
  final String totalPc ;
  final int index ;
  final int id ;
  const ItemCart({ required this.image,required this.index,required this.totalPc,required this.count, required this.text, required this.sale, required this.cubit, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width(context) * 0.002,
          vertical: height(context) * 0.02),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(image,
                  fit: BoxFit.fill, width: width(context) * 0.2,height: height(context)*0.12,)),
          SizedBox(width: width(context) * 0.02),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: width(context) * 0.4,
                  child: CustomText(
                      text: text,
                      color: AppColors.textColor,
                      fontSize: AppFonts.t6,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2)),
              SizedBox(height: height(context) * 0.01),
              Row(
                children: [
                  CustomText(
                      text: LocaleKeys.PicPRice.tr(),
                      color: AppColors.textColor,
                      fontSize: AppFonts.t8),
                  CustomText(
                      text: "$sale ${LocaleKeys.Rs.tr()}",
                      color: AppColors.orangeColor,
                      fontSize: AppFonts.t8),
                ],
              ),
              SizedBox(height: height(context) * 0.01),
              Row(
                children: [
                  CustomText(
                      text: LocaleKeys.AllPrice.tr(),
                      color: AppColors.textColor,
                      fontSize: AppFonts.t8),
                  CustomText(
                      text: "$totalPc ${LocaleKeys.Rs.tr()}",
                      color: AppColors.orangeColor,
                      fontSize: AppFonts.t8),
                ],
              ),
            ],
          ),
          SizedBox(width: width(context)*0.02),
          Align(
            alignment: AlignmentDirectional.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: (){
                    cubit.plus(
                      context: context,
                      index: index,
                      id: id
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: width(context)*0.022,vertical: height(context)*0.01),
                    decoration: BoxDecoration(
                      color: AppColors.shadowBlue,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(
                      child: Image.asset(AppImages.add,scale: 4)
                    )
                  )
                ),
                SizedBox(width: width(context)*0.035),
                CustomText(text: count,color: AppColors.greyText,fontSize: AppFonts.t5),
                SizedBox(width: width(context)*0.035),
                GestureDetector(
                  onTap: (){
                    cubit.minus(
                        context: context,
                        index: index,
                        id: id
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: width(context)*0.022,vertical: height(context)*0.017),
                    decoration: BoxDecoration(
                      color: AppColors.shadowBlue,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(
                      child: Image.asset(AppImages.minus,scale: 4.2),
                    )
                  )
                )
              ]
            )
          )


        ]
      )
    );
  }
}
