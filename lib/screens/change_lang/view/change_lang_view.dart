import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import '../../../components/custom_text.dart';
import '../../../components/navigation.dart';
import '../../../components/style/colors.dart';
import '../../../components/style/images.dart';
import '../../../components/style/size.dart';
import '../../../generated/locale_keys.g.dart';
import '../controller/change_lang_cubit.dart';
import '../controller/change_lang_states.dart';

class ChangeLangScreen extends StatelessWidget {
  const ChangeLangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangeLangCubit(),
      child: BlocBuilder<ChangeLangCubit, ChangeLangStates>(
          builder: (context, state) {
            final cubit = ChangeLangCubit.get(context);
            return SafeArea(
              bottom: false,
              child: Scaffold(
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width(context)*0.03,vertical: height(context)*0.02),
                  child: Column(
                    children: [
                      Row(children: [
                        GestureDetector(
                            onTap: () {
                              navigatorPop(context: context);
                            },
                            child: Image.asset(
                                context.locale.languageCode == "ar"
                                    ? AppImages.arrowAR
                                    : AppImages.arrowEN,
                                scale: 3.7)),
                        SizedBox(width: width(context)*0.29),
                        CustomText(
                            text: LocaleKeys.Language.tr(),
                            color: AppColors.textColor,
                            fontSize: AppFonts.t2),

                      ]),
                      SizedBox(height: height(context)*0.06),
                      Padding(
                        padding:  EdgeInsetsDirectional.only(bottom: height(context)*0.02),
                        child: GestureDetector(
                          onTap: (){
                            cubit.changeArabicLang(context: context);
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: width(context)*0.03,vertical: height(context)*0.02),
                              decoration: BoxDecoration(
                                  color:  CacheHelper.getData(key: AppCached.appLanguage)=="ar"?AppColors.notificationColor:AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Row(
                                  children: [
                                    CustomText(text: "اللغة العربية",color: CacheHelper.getData(key: AppCached.appLanguage)=="ar"?AppColors.textOrange:AppColors.textColor,fontSize: AppFonts.t6),
                                    CacheHelper.getData(key: AppCached.appLanguage)=="ar"?const Spacer():const SizedBox.shrink(),
                                    CacheHelper.getData(key: AppCached.appLanguage)=="ar"? Image.asset(AppImages.mark,scale: 4):const SizedBox.shrink(),
                                  ]
                              )
                          )
                        )
                      ),
                      Padding(
                        padding:  EdgeInsetsDirectional.only(bottom: height(context)*0.02),
                        child: GestureDetector(
                          onTap: (){
                            cubit.changeEnglishLang(context: context);
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: width(context)*0.03,vertical: height(context)*0.02),
                              decoration: BoxDecoration(
                                  color: CacheHelper.getData(key: AppCached.appLanguage)=="en"?AppColors.notificationColor:AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Row(
                                  children: [
                                    CustomText(text: "English",color:  CacheHelper.getData(key: AppCached.appLanguage)=="en"?AppColors.textOrange:AppColors.textColor,fontSize: AppFonts.t6),
                                    CacheHelper.getData(key: AppCached.appLanguage)=="en"?const Spacer():const SizedBox.shrink(),
                                    CacheHelper.getData(key: AppCached.appLanguage)=="en"? Image.asset(AppImages.mark,scale: 4):const SizedBox.shrink(),
                                  ]
                              )
                          )
                        )
                      )


                    ]
                  )
                )
              )
            );
          })
    );
  }
}
