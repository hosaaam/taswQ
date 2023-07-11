import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/generated/locale_keys.g.dart';

import '../../../components/style/colors.dart';
import '../../../components/style/images.dart';
import '../../../components/style/size.dart';

class ItemNotify extends StatelessWidget {
  final bool? isOnline ;
  final String? notifyBody ;
  final String? notifyTime ;
  final String? image ;
  ItemNotify({required this.isOnline,required this.notifyBody,required this.notifyTime,this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
        bottom:height(context) * 0.02 ,
          top: height(context) * 0.02,
          start: width(context) * 0.03,
          end: width(context) * 0.01
      ),
      decoration: BoxDecoration(
          color:isOnline==false? AppColors.whiteColor:AppColors.notificationColor,
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                        isOnline==true? Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: Image.asset(AppImages.notifyIcons,
                                    fit: BoxFit.fill, width: width(context) * 0.15)),
                            Image.asset(AppImages.online,scale: 3.5),
                          ],
                        ):
                        ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.asset(AppImages.notifyIcons,
                  fit: BoxFit.fill, width: width(context) * 0.15)),
                        SizedBox(width: width(context) * 0.04),
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    width: width(context) * 0.52,
                                    child: CustomText(
                                        text: notifyBody!,
                                        color: AppColors.greyText,
                                        fontSize: AppFonts.t8,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3)),
                                SizedBox(width: width(context)*0.03),
                                Column(
                                  children: [
                                    SizedBox(height: height(context)*0.05),
                                    CustomText(text: notifyTime!,color: AppColors.textOrange,fontSize: AppFonts.t9)
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: height(context)*0.02,),
                            if(image!=null)
                              Image.network(image!,height: height(context)*0.3,width: width(context)*0.4,)
                          ],
                        )
        ]
      )
    );
  }
}
