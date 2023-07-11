import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/navigation.dart';

import '../../../core/local/app_cached.dart';
import '../../../shared/local/cache_helper.dart';
import '../../btnNavBar/view/btn_nav_bar_view.dart';
import 'change_lang_states.dart';

class ChangeLangCubit extends Cubit<ChangeLangStates> {
  ChangeLangCubit() : super(ChangeLangInitialState());

  static ChangeLangCubit get(context) => BlocProvider.of(context);


  void changeArabicLang({required BuildContext context}) async {
    CacheHelper.saveData(AppCached.appLanguage, 'ar');
    await context.setLocale(const Locale('ar'));
    debugPrint("the language is ${context.locale}");
    emit(ChangeLanguageSuccess());
    navigateAndFinish(context: context, widget: const BottomNavBar());
  }

  void changeEnglishLang({required BuildContext context}) async {
    CacheHelper.saveData(AppCached.appLanguage, 'en');
    await context.setLocale(const Locale('en'));
    debugPrint("the language is ${context.locale}");
    emit(ChangeLanguageSuccess());
    navigateAndFinish(context: context, widget: const BottomNavBar());
  }

}