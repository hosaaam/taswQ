import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_button.dart';
import 'package:taswqly/components/custom_loading.dart';
import 'package:taswqly/components/custom_phone_field.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/components/visitor_dialog.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/screens/btnNavBar/view/btn_nav_bar_view.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../components/custom_text.dart';
import '../../../../components/style/colors.dart';
import '../../../../components/style/images.dart';
import '../../../../components/style/size.dart';
import '../../../../generated/locale_keys.g.dart';
import '../controller/login_cubit.dart';
import '../controller/login_states.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return GestureDetector(
      onTap: (){
        currentFocus.unfocus();
      },
      child: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocBuilder<LoginCubit, LoginStates>(builder: (context, state) {
          final cubit = LoginCubit.get(context);
          return SafeArea(
            bottom: false,
            child: Scaffold(
              body: Container(
                height: height(context),
                width: width(context),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImages.bG), fit: BoxFit.fill)),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: height(context) * 0.05,
                        horizontal: width(context) * 0.05),
                    child: Form(
                      key: cubit.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(AppImages.logBlue,
                              width: width(context) * 0.45),
                          SizedBox(height: height(context) * 0.1),
                          CustomText(
                              text: LocaleKeys.SignIn.tr(),
                              color: AppColors.textColor,
                              fontSize: AppFonts.h4,
                              fontWeight: FontWeight.w500),
                          SizedBox(height: height(context) * 0.03),
                          CustomText(
                              text: LocaleKeys.PleaseEnterYourMobile.tr(),
                              color: AppColors.greyText,
                              fontSize: AppFonts.t3,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.center),
                          SizedBox(height: height(context) * 0.07),
                          CustomPhoneField(
                              onChangedPhone: (phone) {
                                cubit.getPhone(phone.number);
                              },
                              onChangedCode: (phone) {},
                              ctrl: cubit.phoneCtrl,
                              hint: LocaleKeys.MobileNumber.tr()),
                          SizedBox(height: height(context) * 0.07),
                          state is LoginLoadingState ? const CustomLoading():CustomButton(
                              text: LocaleKeys.Login.tr(),
                              onPressed: () async{
                                await cubit.login(context: context);

                              },
                              isOrange: false),
                          SizedBox(height: height(context) * 0.02),
                          CustomButton(
                              text: LocaleKeys.RegisterWithUs.tr(),
                              onPressed: () async{
                                if (!await launchUrl(Uri.parse("https://tasawqly.elkhayal.co/register"),
                                  mode: LaunchMode.externalApplication,
                                )) {
                                  throw 'Could not launch https://tasawqly.elkhayal.co/register';
                                }
                                //navigateTo(context:context, widget:const RegisterScreen());
                              },
                              isOrange: true),
                          SizedBox(height: height(context) * 0.06),
                          InkWell(
                              onTap: () {
                                print("skip");
                                navigateTo(context: context, widget: const BottomNavBar());
                              },
                              child: CustomText(text: LocaleKeys.SkipRegistration.tr(),
                                color: AppColors.textColor,
                                fontSize: AppFonts.t4,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w500)),
                          SizedBox(height: height(context) * 0.02)

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
