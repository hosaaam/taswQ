import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/generated/locale_keys.g.dart';
import 'package:taswqly/screens/auth/login/view/login_view.dart';
import 'package:taswqly/screens/edit_profile/view/edit_profile_view.dart';
import 'package:taswqly/shared/local/cache_helper.dart';

import '../../../components/custom_text.dart';
import '../../../components/style/colors.dart';
import '../../../components/style/images.dart';
import '../../../components/style/size.dart';
import '../../settings/view/settings_view.dart';

class DetailsProfile extends StatelessWidget {
  const DetailsProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: height(context)*0.02),
      child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: width(context)*0.02,vertical: height(context)*0.197),
              decoration: BoxDecoration(color: AppColors.textColor,borderRadius: BorderRadius.circular(8)),
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(AppImages.shaddow)),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: width(context)*0.02,vertical: height(context)*0.015),
                child: Column(
                    children: [
                      Row(
                        children: [
                          CacheHelper.getData(key: AppCached.userToken)!=null?GestureDetector(
                            onTap: (){
                              debugPrint("edittttt");
                              navigateTo(context:context, widget:const EditProfileScreen());
                            },
                            child: Image.asset(context.locale.languageCode == "ar"?AppImages.editAr:AppImages.editEn,scale: 3.5),

                          ):GestureDetector(
                            onTap: (){
                              navigateAndFinish(context: context, widget: const LoginScreen());
                            },
                            child: CustomText(
                                text: LocaleKeys.Login.tr(),
                                fontWeight: FontWeight.bold,
                                fontSize: AppFonts.t4,
                                color: AppColors.whiteColor,
                                decoration: TextDecoration.underline,
                                textAlign: TextAlign.center),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: (){
                              debugPrint("settings");
                              navigateTo(context:context, widget:const SettingsScreen());
                            },
                            child: Image.asset(AppImages.setting,scale: 3.5),

                          ),

                        ],
                      ),
                      SizedBox(height: height(context)*0.02),
                      CacheHelper.getData(key: AppCached.userToken)!=null?CircleAvatar(backgroundColor: AppColors.textColor,
                          radius: 55,
                          backgroundImage: NetworkImage(CacheHelper.getData(key: AppCached.userPhoto))
                      ):SizedBox(height: height(context)*0.08),
                      SizedBox(height: height(context)*0.04),
                      CacheHelper.getData(key: AppCached.userToken)!=null?CustomText(text: CacheHelper.getData(key: AppCached.userName),color: AppColors.whiteColor,fontSize: AppFonts.t5):CustomText(
                          text: LocaleKeys.CannotAccessContent.tr(),
                          fontWeight: FontWeight.bold,
                          fontSize: AppFonts.t4,
                          color: AppColors.whiteColor,
                          textAlign: TextAlign.center),
                      SizedBox(height: height(context)*0.02),
                      CacheHelper.getData(key: AppCached.userToken)!=null?CustomText(text: CacheHelper.getData(key: AppCached.userEmail),color: AppColors.textOrange,fontSize: AppFonts.t8):const SizedBox.shrink()
                    ]
                )
            )

          ]
      ),
    );
  }
}
