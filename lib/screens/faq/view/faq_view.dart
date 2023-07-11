import 'package:easy_localization/easy_localization.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_loading.dart';
import 'package:taswqly/components/style/images.dart';
import 'package:taswqly/components/style/size.dart';
import '../../../components/custom_text.dart';
import '../../../components/navigation.dart';
import '../../../components/style/colors.dart';
import '../../../generated/locale_keys.g.dart';
import '../controller/faq_cubit.dart';
import '../controller/faq_states.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FaqCubit()..fetchFaq(context: context),
        child: BlocBuilder<FaqCubit, FaqStates>(builder: (context, state) {
          final cubit = FaqCubit.get(context);
          return SafeArea(
              bottom: false,
              child: Scaffold(
                  body: Container(
                      width: width(context),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AppImages.faqBG),
                              fit: BoxFit.cover)),
                      child: Column(
                          children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width(context) * 0.03,
                              vertical: height(context) * 0.03),
                          child: Row(children: [
                            GestureDetector(
                                onTap: () {
                                  navigatorPop(context: context);
                                },
                                child: Image.asset(
                                    context.locale.languageCode == "ar"
                                        ? AppImages.arrowARWhite
                                        : AppImages.arrowENWhite,
                                    scale: 3.7)),
                            const Spacer(flex: 3),
                            CustomText(
                                text: LocaleKeys.FAQ.tr(),
                                color: AppColors.whiteColor,
                                fontSize: AppFonts.t2),
                            const Spacer(flex: 4),
                          ]),
                        ),
                        SizedBox(height: height(context) * 0.08),
                        state is FaqLoadingState?
                            const Expanded(child: CustomLoading()):
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: width(context) * 0.03,
                              vertical: height(context) * 0.02),
                          decoration: const BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25),
                                  topLeft: Radius.circular(25))),
                          child: ListView.separated(
                            shrinkWrap: true,
                               physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => ExpansionTileCard(
                                expandedColor: Colors.white,
                                  elevation: 5,
                                  duration: const Duration(milliseconds: 700),
                                  animateTrailing: true,
                                  trailing: Image.asset(AppImages.top,scale: 3.5),
                                  // leading: Image.asset(AppImages.down,scale: 3.5),
                                  // onExpansionChanged: (bool isExpanded){
                                  // print("-------------");
                                  //   cubit.change(isExpanded,index);
                                  //   print(isExpanded);
                                  // },
                                  shadowColor: AppColors.whiteColor,
                                  title:  CustomText(
                                      text: cubit.faQModel!.data![index].ask!,
                                      fontSize: AppFonts.t4,
                                      color: cubit.isExpanded==false?
                                      AppColors.textColor:AppColors.orangeColor
                                  ),
                                  children: [
                                    Padding(
                                        padding:  EdgeInsets.symmetric(horizontal:width(context)*0.04,vertical: height(context)*0.015),
                                        child:  CustomText(text: cubit.faQModel!.data![index].answer!,color: AppColors.greyText,fontSize: AppFonts.t5)
                                    )
                                  ]),
                              separatorBuilder: (context, index) => SizedBox(height: height(context)*0.02),
                              itemCount: cubit.faQModel!.data!.length),
                        ))
                      ]))));
        }));
  }
}
