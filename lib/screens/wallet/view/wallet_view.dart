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
import '../controller/wallet_cubit.dart';
import '../controller/wallet_states.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WalletCubit(),
      child: BlocBuilder<WalletCubit, WalletStates>(
          builder: (context, state) {
            final cubit = WalletCubit.get(context);
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
                            text: LocaleKeys.Wallet.tr(),
                            color: AppColors.textColor,
                            fontSize: AppFonts.t2),
                        const Spacer(flex: 4),
                      ]),
                      SizedBox(height: height(context)*0.23),
                      Image.asset(AppImages.wallet,scale: 3.5),
                      SizedBox(height: height(context)*0.05),
                      CustomText(text: LocaleKeys.CurrentBalance.tr(),color: AppColors.textColor,fontSize: AppFonts.h4),
                      SizedBox(height: height(context)*0.02),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(text: CacheHelper.getData(key: AppCached.userBalance),fontSize: AppFonts.t2,color: AppColors.orangeColor),
                          SizedBox(width: width(context)*0.01),
                          CustomText(text: LocaleKeys.Rs.tr(),fontSize: AppFonts.t2,color: AppColors.orangeColor)
                        ]
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
