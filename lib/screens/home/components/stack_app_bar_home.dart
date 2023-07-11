import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/components/visitor_dialog.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/generated/locale_keys.g.dart';
import 'package:taswqly/screens/auth/login/view/login_view.dart';
import 'package:taswqly/screens/notification/view/notification_view.dart';
import 'package:taswqly/shared/local/cache_helper.dart';

import '../../../components/custom_text.dart';
import '../../../components/style/colors.dart';
import '../../../components/style/images.dart';
import '../../../components/style/size.dart';

class StackAppBarHome extends StatelessWidget {
  const StackAppBarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
              height: height(context)*0.37,
              decoration: const BoxDecoration(
                color: AppColors.textColor,
                  image: DecorationImage(image: AssetImage(AppImages.appBar),fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(18),bottomLeft:Radius.circular(18))
              )
          ),
          Image.asset(AppImages.shadoww,fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width(context)*0.04,vertical: height(context)*0.03),
            child: Column(
              children: [
                Row(
                    children: [
                      CacheHelper.getData(key: AppCached.userToken)!=null ?CircleAvatar(
                          backgroundImage: NetworkImage(CacheHelper.getData(key: AppCached.userPhoto)),
                          radius: 30,
                          backgroundColor: AppColors.textColor
                      ):const SizedBox.shrink(),
                      SizedBox(width: width(context)*0.04),
                      CacheHelper.getData(key: AppCached.userToken)!=null ?Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: LocaleKeys.Hello.tr(),color: AppColors.whiteColor,fontSize: AppFonts.t5),
                          SizedBox(height: height(context)*0.02),
                          CustomText(text: CacheHelper.getData(key: AppCached.userName),color: AppColors.textOrange,fontSize: AppFonts.t5),
                        ],
                      ):GestureDetector(
                        onTap: (){
                          navigateAndFinish(context: context, widget: const LoginScreen());
                        },
                        child: CustomText(
                            text: LocaleKeys.Login.tr(),
                            fontWeight: FontWeight.bold,
                            fontSize: AppFonts.t5,
                            color: AppColors.whiteColor,
                            decoration: TextDecoration.underline,
                            textAlign: TextAlign.center),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: (){
                          CacheHelper.getData(key: AppCached.userToken)!=null ?navigateTo(context:context, widget: const NotificationScreen()):showDialog(context: context, builder: (context)=> const VisitorDialog());
                        },
                        child: Image.asset(context.locale.languageCode =="ar"?AppImages.notification:AppImages.notificationEn,scale:4),
                      ),
                    ]
                ),
                CacheHelper.getData(key: AppCached.userToken)!=null ?SizedBox(height: height(context)*0.1):SizedBox(height: height(context)*0.13),
                CacheHelper.getData(key: AppCached.userToken)!=null ?RichText(
                  text: TextSpan(
                    text: '${CacheHelper.getData(key: AppCached.userBalance)}\t',
                    style: TextStyle(color: AppColors.whiteColor,fontSize: AppFonts.h),
                    children:  <TextSpan>[
                      TextSpan(text: LocaleKeys.Rs.tr(), style: TextStyle(fontSize: AppFonts.t1)),
                    ],
                  ),
                ):CustomText(
                    text: LocaleKeys.CannotAccessContent.tr(),
                    fontWeight: FontWeight.bold,
                    fontSize: AppFonts.t5,
                    color: AppColors.whiteColor,
                    textAlign: TextAlign.center),
                CacheHelper.getData(key: AppCached.userToken)!=null ?SizedBox(height: height(context)*0.01):const SizedBox.shrink(),
                CacheHelper.getData(key: AppCached.userToken)!=null ?CustomText(text: LocaleKeys.Total.tr(),color: AppColors.textOrange,fontSize: AppFonts.t7):const SizedBox.shrink(),
              ],
            ),
          ),

        ]
    ) ;
  }
}
