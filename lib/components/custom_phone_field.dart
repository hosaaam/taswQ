import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import 'style/colors.dart';
import 'style/size.dart';

class CustomPhoneField extends StatelessWidget {
  final String? hint;
  final TextEditingController? ctrl;
  final String? phoneKey;
  final EdgeInsetsGeometry? contentPadding;
  final Function(PhoneNumber) onChangedPhone ;
  final Function(Country) onChangedCode ;

  const CustomPhoneField({Key? key, this.hint,this.phoneKey, this.contentPadding, this.ctrl, required this.onChangedPhone, required this.onChangedCode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: ctrl,
      dropdownTextStyle:  TextStyle(
          color: AppColors.textColor,fontSize: AppFonts.t6),
      dropdownIcon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.transparent,
        size: 8
      ),
      cursorColor: AppColors.textColor,
      cursorHeight: 20,
      style: TextStyle(fontSize: AppFonts.t5, color: AppColors.textColor),
      decoration: InputDecoration(
          // filled: true,
          // fillColor: AppColors.whiteColor,
          contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: height(context) * 0.02),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(5),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
              const BorderSide(color: AppColors.greyTextField)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: AppColors.textColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
              const BorderSide(color: AppColors.greyTextField)),
          hintText: hint,
          hintStyle: const TextStyle(
            color: AppColors.greyText
          )
          ),
      initialCountryCode:phoneKey??"SA",
      disableLengthCheck: true,
      onChanged: onChangedPhone,
      onCountryChanged: onChangedCode,
      textAlign: context.locale.languageCode == "ar"
          ? TextAlign.right
          : TextAlign.left
    );
  }
}