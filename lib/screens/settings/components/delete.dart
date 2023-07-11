import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taswqly/components/custom_button.dart';
import 'package:taswqly/components/custom_loading.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/components/style/colors.dart';
import 'package:taswqly/components/style/images.dart';
import 'package:taswqly/components/style/size.dart';
import 'package:taswqly/generated/locale_keys.g.dart';
import 'package:taswqly/screens/settings/controller/settings_cubit.dart';
import 'package:taswqly/screens/settings/controller/settings_states.dart';

class DeletePopup extends StatelessWidget {
  final SettingsCubit cubit ;
  final dynamic state ;
  const DeletePopup({Key? key, required this.cubit, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyTextField.withOpacity(0.001),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: width(context)*0.05),
          padding: EdgeInsets.symmetric(horizontal: width(context)*0.03,vertical: height(context)*0.02),
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8)
          ),
          child:SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: GestureDetector(
                    onTap: (){
                      navigatorPop(context: context);
                    },
                    child: Image.asset(AppImages.close,scale: 3.5),

                  ),
                ),
                SizedBox(height: height(context)*0.04),
                CustomText(text: LocaleKeys.ConfirmAccountDeletion.tr(),color: AppColors.textColor,fontSize: AppFonts.t3),
                SizedBox(height: height(context)*0.04),
                state  ? const CustomLoading() :CustomButton(text: LocaleKeys.Yes.tr(), onPressed: ()async{await cubit.deleteAcc(context: context);}, isOrange: false),
                SizedBox(height: height(context)*0.015),
                CustomButton(text: LocaleKeys.No.tr(), onPressed: (){
                  navigatorPop(context: context);
                }, isOrange: true)
              ]
            )
          )
        )
      )
    );
  }
}
