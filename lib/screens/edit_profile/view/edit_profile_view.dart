import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_loading.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/shared/local/cache_helper.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_dropdown.dart';
import '../../../components/custom_text.dart';
import '../../../components/custom_textfield.dart';
import '../../../components/navigation.dart';
import '../../../components/style/colors.dart';
import '../../../components/style/images.dart';
import '../../../components/style/size.dart';
import '../../../generated/locale_keys.g.dart';
import '../../profile/components/stack_appBar.dart';
import '../components/bottom_sheet.dart';
import '../controller/edit_profile_cubit.dart';
import '../controller/edit_profile_states.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit()..getData(context: context),
      child: BlocBuilder<EditProfileCubit, EditProfileStates>(
          builder: (context, state) {
        final cubit = EditProfileCubit.get(context);
        return SafeArea(
          bottom: false,
          child: Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  StackAppBar(
                      textAppBar: LocaleKeys.EditsDetails.tr(),
                      backgroundImage: cubit.file != null ? FileImage(File(cubit.file!.path)): NetworkImage(CacheHelper.getData(key: AppCached.userPhoto)) as ImageProvider,
                      isEdit: true,
                      onTap: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25))
                            ),
                            context: context,
                            builder: (BuildContext cont) {
                              return CustomBottomSheet(
                                onPressedCamera: () {
                                  cubit.pickFromCamera(context: context);
                                  navigatorPop(context: context);
                                },
                                onPressedGallery: () {
                                  cubit.pickFromGallery(context: context);
                                  navigatorPop(context: context);
                                },
                              );
                            });
                      },
                      onTapBack: () {
                        navigatorPop(context: context);
                      }),
                  SizedBox(height: height(context) * 0.02),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: height(context) * 0.03,
                        horizontal: width(context) * 0.05),
                    child: Column(
                      children: [
                        CustomTextFormField(
                            prefixIcon:
                                Image.asset(AppImages.person, scale: 3.5),
                            hint: LocaleKeys.UserName.tr(),
                            maxLines: 1,
                            ctrl: cubit.nameCtrl,
                            type: TextInputType.name,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: width(context) * 0.02,
                                vertical: height(context) * 0.02)),
                        SizedBox(height: height(context) * 0.02),
                        CustomTextFormField(
                            prefixIcon: Image.asset(AppImages.email,
                                width: width(context) * 0.05, scale: 3.5),
                            hint: LocaleKeys.EmailAddress.tr(),
                            maxLines: 1,
                            ctrl: cubit.emailCtrl,
                            type: TextInputType.emailAddress,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: width(context) * 0.02,
                                vertical: height(context) * 0.02)),
                        SizedBox(height: height(context) * 0.02),
                        state is CitiesLoadingState ? const CustomLoading():CustomDropDown(
                            hintText: LocaleKeys.City.tr(),
                            onChanged: (value) {
                              cubit.changeDropDown(value);
                            },
                            items: List.generate(
                                cubit.citiesModel!.data!.length,
                                (index) => DropdownMenuItem<String>(
                                    value: cubit.citiesModel!.data![index].id.toString(),
                                    child: CustomText(
                                        text: cubit.citiesModel!.data![index].name!,
                                        fontSize: AppFonts.t5,
                                        color: AppColors.textColor))),
                            prefixIcon:
                                Image.asset(AppImages.location, scale: 3.5),
                            dropDownValue: cubit.dropDownValue),
                        SizedBox(height: height(context) * 0.07),
                        state is UpDateLoadingState ? const CustomLoading() :CustomButton(
                            text: LocaleKeys.SaveEdits.tr(),
                            onPressed: () async{
                              if(cubit.file != null){
                                await cubit.upDateImage(context: context);
                                await cubit.upDateProfile(context: context);
                              }else{
                                await cubit.upDateProfile(context: context);
                              }
                            },
                            isOrange: false)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
