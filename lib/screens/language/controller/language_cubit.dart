import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/navigation.dart';
import '../../../core/local/app_cached.dart';
import '../../../shared/local/cache_helper.dart';
import '../../auth/login/view/login_view.dart';
import 'language_states.dart';

class LanguageCubit extends Cubit<LanguageStates> {
  LanguageCubit() : super(LanguageInitialState());

  static LanguageCubit get(context) => BlocProvider.of(context);

  void selectAR({required BuildContext context}) async {

    await context.setLocale(const Locale("ar"));
    CacheHelper.saveData(AppCached.appLanguage, 'ar');
    debugPrint('the current lang is ${context.locale}');
    navigateTo(context:context, widget:const  LoginScreen());
    emit(LanguageSelected());

  }
  void selectEN({required BuildContext context}) async {

    await context.setLocale(const Locale('en'));
    CacheHelper.saveData(AppCached.appLanguage, 'en');
    debugPrint('the current lang is ${context.locale}');
    navigateTo(context:context, widget:const  LoginScreen());
    emit(LanguageSelected());

  }

}