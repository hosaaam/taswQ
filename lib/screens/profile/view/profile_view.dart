import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_button.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/components/style/images.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/screens/edit_profile/view/edit_profile_view.dart';
import 'package:taswqly/screens/profile/components/profile_item.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import '../../../components/style/size.dart';
import '../../../generated/locale_keys.g.dart';
import '../components/stack_appBar.dart';
import '../controller/profile_cubit.dart';
import '../controller/profile_states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfile(context: context),
      child: BlocBuilder<ProfileCubit, ProfileStates>(
          builder: (context, state) {
            final cubit = ProfileCubit.get(context);
            return SafeArea(
              bottom: false,
              child: Scaffold(
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      StackAppBar(textAppBar: LocaleKeys.MyProfile.tr(),
                        isEdit: false,
                        onTapBack: () {
                          navigatorPop(context: context);
                        }
                      ),
                      SizedBox(height: height(context) * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width(
                            context) * 0.05),
                        child: Column(
                          children: [
                             ProfileItem(image: AppImages.personBlue, text: CacheHelper.getData(key: AppCached.userName)),
                            SizedBox(height: height(context) * 0.025),
                             ProfileItem(image: AppImages.emailBlue, text: CacheHelper.getData(key: AppCached.userEmail)),
                            SizedBox(height: height(context) * 0.025),
                             ProfileItem(image: AppImages.locationBlue, text: CacheHelper.getData(key: AppCached.userCityName)),
                            SizedBox(height: height(context) * 0.07),
                            CustomButton(text: LocaleKeys.EditsDetails.tr(),
                                onPressed: () {
                                  navigateTo(context:context, widget:const EditProfileScreen());
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
