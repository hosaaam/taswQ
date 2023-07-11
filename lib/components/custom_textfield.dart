import 'package:flutter/material.dart';

import 'style/colors.dart';
import 'style/size.dart';

class CustomTextFormField extends StatelessWidget {
 final String? hint;
 final TextInputType? type;
 final Widget? prefixIcon;
 final Widget? suffixIcon;
 final Color? fillColor;
 final bool isSecure ;
 final TextEditingController? ctrl;
 final EdgeInsetsGeometry? contentPadding;
 final int? maxLines;
 final void Function()? onTap;
 final bool? isOnlyRead;
 final bool? isEnabled;
  const CustomTextFormField(
      {Key? key,
      this.hint,
      this.type,
      this.contentPadding,
      this.ctrl,
      this.isSecure = false,
      this.maxLines=1,
      this.prefixIcon,
      this.suffixIcon,
      this.isOnlyRead=false,
      this.onTap, this.fillColor, this.isEnabled})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: ctrl,
      readOnly: isOnlyRead!,
      enabled: isEnabled,
      maxLines: maxLines,
      cursorColor: AppColors.textColor,
      cursorHeight: 20,
      style: TextStyle(fontSize: AppFonts.t5, color: AppColors.textColor),
      decoration: InputDecoration(
          //filled: true,
          fillColor: fillColor,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(vertical: height(context) * 0.02),
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
            color: AppColors.greyText,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon),
      keyboardType: type,
      obscureText: isSecure,
    );
  }
}
