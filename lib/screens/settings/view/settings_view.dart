import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/screens/change_lang/view/change_lang_view.dart';
import 'package:taswqly/screens/more/components/more_item.dart';
import 'package:taswqly/screens/settings/components/delete.dart';
import 'package:taswqly/shared/local/cache_helper.dart';

import '../../../components/custom_text.dart';
import '../../../components/navigation.dart';
import '../../../components/style/colors.dart';
import '../../../components/style/images.dart';
import '../../../components/style/size.dart';
import '../../../generated/locale_keys.g.dart';
import '../controller/settings_cubit.dart';
import '../controller/settings_states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SettingsCubit(),
        child: BlocBuilder<SettingsCubit, SettingsStates>(
            builder: (context, state) {
          final cubit = SettingsCubit.get(context);
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
                              text: LocaleKeys.Settings.tr(),
                              color: AppColors.textColor,
                              fontSize: AppFonts.t2),
                          const Spacer(flex: 4)
                        ]),
                        SizedBox(height: height(context) * 0.07),
                        CacheHelper.getData(key: AppCached.userToken)!=null?MoreItem(
                            text: LocaleKeys.Notification.tr(),
                            onTap: () {},
                            isNotify: true,
                            widget: SizedBox(
                              height: height(context)*0.03,
                              child: Switch(
                                activeColor: AppColors.textColor,
                                  onChanged: (value)async {
                                    cubit.toggleNotify();
                                   await cubit.activateNotify(context: context);
                                  },
                                  value: cubit.notify),
                            )):const SizedBox.shrink(),
                        CacheHelper.getData(key: AppCached.userToken)!=null?SizedBox(height: height(context) * 0.005):const SizedBox.shrink(),
                        MoreItem(
                            text: LocaleKeys.Language.tr(),
                            onTap: () {
                              navigateTo(context:context, widget:const ChangeLangScreen());
                            }),
                        SizedBox(height: height(context) * 0.005),
                        CacheHelper.getData(key: AppCached.userToken)!=null?MoreItem(
                            text: LocaleKeys.AccountDelete.tr(),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) =>  DeletePopup(cubit: cubit,state: state is DeleteAccLoadingState));
                            }):const SizedBox.shrink()
                      ]))));
        }));
  }
}
