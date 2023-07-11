import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/style/colors.dart';
import 'package:taswqly/components/style/size.dart';
import 'package:taswqly/generated/locale_keys.g.dart';
import 'package:taswqly/screens/language/controller/language_cubit.dart';

import '../../../components/style/images.dart';
import '../controller/language_states.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: BlocBuilder<LanguageCubit, LanguageStates>(
          builder: (context, state) {
            final cubit = LanguageCubit.get(context);
            return SafeArea(
              bottom: false,
              child: Scaffold(
                body: Container(
                  height: height(context),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppImages.bG),
                          fit: BoxFit.fill
                      )
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: height(context)*0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(AppImages.logBlue,width: width(context)*0.45),
                            SizedBox(height: height(context)*0.1),
                            CustomText(text: LocaleKeys.SelectLang.tr(),color: AppColors.textColor,fontSize: AppFonts.h4,fontWeight: FontWeight.w500),
                            SizedBox(height: height(context)*0.1),
                            GestureDetector(
                              onTap: (){
                                cubit.selectAR(context: context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: height(context)*0.055),
                                decoration:const BoxDecoration(image: DecorationImage(image: AssetImage(AppImages.arabic))),
                                child: Center(child: CustomText(text: "العربية",color: AppColors.orangeColor,fontSize: AppFonts.t3)),
                              ),
                            ),
                            SizedBox(height: height(context)*0.1),
                            GestureDetector(
                              onTap: (){
                                cubit.selectEN(context: context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: height(context)*0.055),
                                decoration:const BoxDecoration(image: DecorationImage(image: AssetImage(AppImages.english))),
                                child: Center(child: CustomText(text: "English",color: AppColors.textColor,fontSize: AppFonts.t3)),
                              ),
                            ),
                            SizedBox(height: height(context)*0.03)

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
