import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:taswqly/components/custom_loading.dart';
import '../../../components/custom_text.dart';
import '../../../components/navigation.dart';
import '../../../components/style/colors.dart';
import '../../../components/style/images.dart';
import '../../../components/style/size.dart';
import '../../../generated/locale_keys.g.dart';
import '../controller/about_us_cubit.dart';
import '../controller/about_us_states.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AboutUsCubit()..getAboutApp(context: context),
      child: BlocBuilder<AboutUsCubit, AboutUsStates>(
          builder: (context, state) {
            final cubit = AboutUsCubit.get(context);
            return SafeArea(
              bottom: false,
              child: Scaffold(
                body: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width(context) * 0.03,
                      vertical: height(context) * 0.02),
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
                        const Spacer(flex: 3),
                        CustomText(
                            text: LocaleKeys.WhoAreWe.tr(),
                            color: AppColors.textColor,
                            fontSize: AppFonts.t2),
                        const Spacer(flex: 4)
                      ]),
                      SizedBox(height: height(context)*0.03),
                      state is AboutAppLoadingState ? const Expanded(child: CustomLoading()):Expanded(child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HtmlWidget(cubit.model!.data!.content!,
                                  textStyle: TextStyle(
                                      color: AppColors.greyText,
                                      fontSize: AppFonts.t5)),
                              SizedBox(height: height(context) * 0.02)
                            ],
                          )))
                    ]
                  )
                )
              )
            );
          })
    );
  }
}
