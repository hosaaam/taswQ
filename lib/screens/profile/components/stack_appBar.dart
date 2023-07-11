
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import '../../../components/custom_text.dart';
import '../../../components/style/colors.dart';
import '../../../components/style/images.dart';
import '../../../components/style/size.dart';

class StackAppBar extends StatelessWidget {
  final bool isEdit ;
  final String textAppBar ;
  final  Function()? onTap;
  final  ImageProvider<Object>? backgroundImage;
  final  Function() onTapBack;
  const StackAppBar({Key? key, required this.isEdit, required this.textAppBar,  this.onTap, required this.onTapBack,  this.backgroundImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height(context)*0.25,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(AppImages.appBar),fit: BoxFit.cover),
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft:Radius.circular(15))
          )
        ),
        Image.asset(AppImages.shadow,fit: BoxFit.cover),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width(context)*0.04,vertical: height(context)*0.035),
          child: Column(
            children: [
              Row(
                  children: [
                    InkWell(
                        onTap:onTapBack,
                        child: Image.asset(context.locale.languageCode=="ar"?AppImages.arrowARWhite:AppImages.arrowENWhite,scale: 4)),
                   context.locale.languageCode =="ar"? SizedBox(width: width(context)*0.2):isEdit==true?SizedBox(width: width(context)*0.23):SizedBox(width: width(context)*0.29),
                    CustomText(text: textAppBar,color: AppColors.whiteColor,fontSize: AppFonts.t4)
                  ]
              )
            ],
          ),
        ),
        Positioned(
          top: height(context)*0.17,
          right: width(context)*0.36,
          child: isEdit == true ? Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
               CircleAvatar(
                backgroundImage: backgroundImage,
                radius: 50,
                backgroundColor: AppColors.whiteColor
              ),
              GestureDetector(
                onTap:onTap,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: width(context)*0.02,vertical: height(context)*0.015),
                  decoration:const BoxDecoration(image: DecorationImage(image: AssetImage(AppImages.cameraBG))),
                  child: Center(child: Image.asset(AppImages.camera,scale: 5))
                )
              )
            ]
          ) :   CircleAvatar(
            backgroundImage: NetworkImage(CacheHelper.getData(key: AppCached.userPhoto)),
            radius: 50,
            backgroundColor: AppColors.whiteColor
          )
        )
      ]
    );
  }
}
