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
import '../controller/terms_and_cond_cubit.dart';
import '../controller/terms_and_cond_states.dart';

class TermsAndCondScreen extends StatelessWidget {
  const TermsAndCondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TermsAndCondCubit()..getTerms(context: context),
        child: BlocBuilder<TermsAndCondCubit, TermsAndCondStates>(
            builder: (context, state) {
          final cubit = TermsAndCondCubit.get(context);
          return SafeArea(
              bottom: false,
              child: Scaffold(
                  body: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width(context) * 0.03,
                          vertical: height(context) * 0.02),
                      child: Column(children: [
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
                              text: LocaleKeys.TermsAndConditions.tr(),
                              color: AppColors.textColor,
                              fontSize: AppFonts.t2),
                          const Spacer(flex: 4),
                        ]),
                        SizedBox(height: height(context) * 0.03),
                        state is TermsAndConditionLoadingState
                            ? const Expanded(child: CustomLoading())
                            : Expanded(
                                child: SingleChildScrollView(
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
                                    ))),

                        /// Old Ui
                        // Expanded(
                        //     child: ListView.separated(
                        //         physics: const BouncingScrollPhysics(),
                        //         shrinkWrap: true,
                        //         itemBuilder: (context, index) => Row(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Image.asset(AppImages.dot,scale: 4),
                        //             SizedBox(width: width(context)*0.03),
                        //             Expanded(child: CustomText(text: LocaleKeys.TestText.tr(),color: AppColors.greyText,fontSize: AppFonts.t6))
                        //           ]
                        //         ),
                        //         separatorBuilder: (context, index) =>
                        //             SizedBox(height: height(context) * 0.025),
                        //         itemCount: 10))
                      ]))));
        }));
  }
}
