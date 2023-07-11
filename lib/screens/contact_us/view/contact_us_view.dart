import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_button.dart';
import 'package:taswqly/components/custom_loading.dart';
import 'package:taswqly/components/custom_textfield.dart';
import 'package:taswqly/components/style/images.dart';
import 'package:taswqly/components/style/size.dart';
import 'package:taswqly/screens/contact_us/components/stack_app_bar.dart';
import '../../../components/custom_text.dart';
import '../../../components/style/colors.dart';
import '../../../generated/locale_keys.g.dart';
import '../controller/contact_us_cubit.dart';
import '../controller/contact_us_states.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ContactUsCubit()..getContact(context: context),
        child: BlocBuilder<ContactUsCubit, ContactUsStates>(
            builder: (context, state) {
          final cubit = ContactUsCubit.get(context);
          return SafeArea(
              child: Scaffold(body: state is GetContactLoadingState ? SizedBox(height: height(context)*0.95,child: const CustomLoading()):Stack(children: [
             StackAppBarContact(cubit: cubit),
             Positioned.fill(
              top: height(context) * 0.38,
              child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: width(context) * 0.05,
                      vertical: height(context) * 0.02),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: AppColors.whiteColor),
                  child: LayoutBuilder(
                      builder: (p0, p1) => SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Form(
                              key: cubit.formKey,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: height(context) * 0.02),
                                    Center(
                                        child: CustomText(
                                            text: LocaleKeys.SendMessage.tr(),
                                            color: AppColors.orangeColor,
                                            fontSize: AppFonts.t4)),
                                    SizedBox(height: height(context) * 0.04),
                                    CustomTextFormField(
                                        ctrl: cubit.nameCtrl,
                                        fillColor: AppColors.notificationColor,
                                        prefixIcon: Image.asset(
                                            AppImages.personBlue,
                                            scale: 3.5),
                                        maxLines: 1,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: width(context) * 0.02,
                                            vertical: height(context) * 0.02),
                                        isOnlyRead: false,
                                        isEnabled: true),
                                    SizedBox(height: height(context) * 0.02),
                                    CustomTextFormField(
                                      ctrl: cubit.phoneCtrl,
                                        prefixIcon: Image.asset(AppImages.phone,
                                            height: height(context) * 0.05,
                                            scale: 3),
                                        hint: LocaleKeys.MobileNumber.tr(),
                                        maxLines: 1,
                                        type: TextInputType.phone),
                                    SizedBox(height: height(context) * 0.02),
                                    CustomTextFormField(
                                        hint: LocaleKeys.Problem.tr(),
                                        maxLines: 4,
                                        ctrl: cubit.messageCtrl,
                                        type: TextInputType.text,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: width(context) * 0.03,
                                            vertical: height(context) * 0.02)),
                                    SizedBox(height: height(context) * 0.05),
                                    state is ContactStoreLoadingState ? const CustomLoading():CustomButton(
                                        text: LocaleKeys.Send.tr(),
                                        onPressed: () async{
                                         await cubit.contactStore(context: context);
                                        },
                                        isOrange: false)
                                  ]),
                            ),
                          ))),
            ),
          ])));
        }));
  }
}
