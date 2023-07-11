import 'package:flutter/material.dart';
import 'package:taswqly/core/local/app_cached.dart';
import '../../components/fade_animation.dart';
import '../../components/navigation.dart';
import '../../components/style/images.dart';
import '../../components/style/size.dart';
import '../../shared/local/cache_helper.dart';
import '../auth/login/view/login_view.dart';
import '../btnNavBar/view/btn_nav_bar_view.dart';
import '../language/view/language_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    /// Handle Yes Or No Ya hadedy
      print("-------------------------");
      print(CacheHelper.getData(key: AppCached.userToken));
      print(CacheHelper.getData(key: AppCached.appLanguage));
      print(CacheHelper.getData(key: AppCached.firstLogin));
    Future.delayed(const Duration(seconds: 3))
        .then((value) => navigateAndFinish(
            context: context,
            widget: CacheHelper.getData(key: AppCached.appLanguage) == null
                ? const LanguageScreen()
                : CacheHelper.getData(key: AppCached.userToken) == null?
                     const LoginScreen()
            :CacheHelper.getData(key: AppCached.userToken) != null  &&CacheHelper.getData(key: AppCached.firstLogin)==true?
            const LoginScreen()  : const BottomNavBar()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImages.splashBG),
                        fit: BoxFit.fill)),
                child: FadeAnimation(
                    1,
                    2,
                    Center(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          Image.asset(AppImages.logoWhite,
                              width: 0.44 * width(context))
                        ]))))));
  }
}
