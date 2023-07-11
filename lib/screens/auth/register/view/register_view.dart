import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_dropdown.dart';
import 'package:taswqly/components/custom_loading.dart';
import 'package:taswqly/components/custom_textfield.dart';
import 'package:taswqly/components/custom_toast.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/screens/terms_and_cond/view/terms_and_cond_view.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_text.dart';
import '../../../../components/style/colors.dart';
import '../../../../components/style/images.dart';
import '../../../../components/style/size.dart';
import '../../../../generated/locale_keys.g.dart';
import '../controller/register_cubit.dart';
import '../controller/register_states.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return GestureDetector(
      onTap: (){
        currentFocus.unfocus();
      },
      child: BlocProvider(
        create: (context) => RegisterCubit()..getCities(context: context),
        child: BlocBuilder<RegisterCubit, RegisterStates>(
            builder: (context, state) {
              final cubit = RegisterCubit.get(context);
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
                              GestureDetector(
                                  onTap: (){
                                    navigatorPop(context:context);
                                  },
                                  child: Align(
                                      alignment: AlignmentDirectional.centerStart,
                                      child: Image.asset(context.locale.languageCode=="ar"?AppImages.arrowAR:AppImages.arrowEN, width: width(context) * 0.1))),
                              SizedBox(height: height(context)*0.06),
                              Image.asset(AppImages.logBlue, width: width(context) * 0.45),
                              SizedBox(height: height(context) * 0.08),
                              CustomText(
                                  text: LocaleKeys.NewAcc.tr(),
                                  color: AppColors.textColor,
                                  fontSize: AppFonts.h4,
                                  fontWeight: FontWeight.w500),
                              SizedBox(height: height(context) * 0.03),
                              CustomText(
                                  text: LocaleKeys.PleaseSomeDetails.tr(),
                                  color: AppColors.greyText,
                                  fontSize: AppFonts.t3,
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.center),
                              SizedBox(height: height(context) * 0.07),
                              CustomTextFormField(ctrl: cubit.nameCtrl,prefixIcon: Image.asset(AppImages.person,scale: 3.5),hint: LocaleKeys.UserName.tr(),maxLines: 1,type: TextInputType.name,contentPadding: EdgeInsets.symmetric(horizontal: width(context)*0.02,vertical: height(context)*0.02)),
                              SizedBox(height: height(context) * 0.02),
                              CustomTextFormField(ctrl: cubit.emailCtrl,prefixIcon: Image.asset(AppImages.email,width: width(context)*0.05,scale: 3.5),hint: LocaleKeys.EmailAddress.tr(),maxLines: 1,type: TextInputType.emailAddress,contentPadding: EdgeInsets.symmetric(horizontal: width(context)*0.02,vertical: height(context)*0.02)),
                              SizedBox(height: height(context) * 0.02),
                              state is CitiesLoadingState ? const CustomLoading() :CustomDropDown(hintText: LocaleKeys.City.tr(), onChanged: (value){
                                cubit.changeDropDown(value);
                              }, items: List.generate(cubit.citiesModel!.data!.length, (index) => DropdownMenuItem<String>(value: cubit.citiesModel!.data![index].id.toString(),child: CustomText(text: cubit.citiesModel!.data![index].name!,fontSize: AppFonts.t5,color: AppColors.textColor))),prefixIcon:Image.asset(AppImages.location,scale: 3.5),dropDownValue: cubit.dropDownValue),
                              SizedBox(height: height(context) * 0.025),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: width(context)*0.055,
                                    child: Checkbox(
                                      value: cubit.isChecked,
                                      checkColor: AppColors.whiteColor,
                                      activeColor: AppColors.textColor,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                                      onChanged: (value) {
                                        cubit.check(value);
                                      },
                                    ),
                                  ),
                                  SizedBox(width: width(context) * 0.02),
                                  CustomText(
                                      text: LocaleKeys.ApprovalOf.tr(),
                                      color: AppColors.textColor,
                                      fontSize: AppFonts.t5),
                                  SizedBox(width: width(context) * 0.015),
                                  GestureDetector(
                                    onTap: (){
                                      navigateTo(context:context, widget:const TermsAndCondScreen());
                                    },
                                    child: CustomText(
                                        text:LocaleKeys.TermsAndConditions.tr(),
                                        color: AppColors.textColor,
                                        fontSize:AppFonts.t5,
                                        decoration: TextDecoration.underline),
                                  )
                                ]
                              ),
                              SizedBox(height: height(context) * 0.05),
                              state is ConfirmRegisterLoadingState ? const CustomLoading(): CustomButton(
                                  text: LocaleKeys.AccountCreation.tr(),
                                  onPressed: ()async{
                                    if(cubit.isChecked == false){
                                      showToast(text: LocaleKeys.AcceptRegister.tr(), state: ToastStates.error);
                                    }else{
                                      cubit.confirmRegister(context: context);

                                    }
                                  },
                                  isOrange: false),
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
