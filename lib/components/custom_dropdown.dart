import 'package:flutter/material.dart';
import '../../../../../../components/style/colors.dart';
import '../../../../../../components/style/images.dart';
import '../../../../../../components/style/size.dart';

class CustomDropDown extends StatelessWidget {
  final String hintText;
  final dynamic dropDownValue;
  final Widget? prefixIcon ;
  final List<DropdownMenuItem<String>> items;
  final void Function(String?) onChanged;
  const CustomDropDown(
      {Key? key,
      required this.hintText,
      this.dropDownValue,
      required this.onChanged,
      required this.items, this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height(context)*0.075,
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        decoration: InputDecoration(
          // filled: true,
          // fillColor: AppColors.whiteColor,
          contentPadding:  EdgeInsets.symmetric(horizontal: width(context)*0.02,vertical: height(context)*0.02),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
              const BorderSide(color: AppColors.greyTextField)),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(5),
            ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
              const BorderSide(color: AppColors.textColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
              const BorderSide(color: AppColors.greyTextField)),
          hintText: hintText,
          prefixIcon: prefixIcon,
          hintStyle: TextStyle(
            color: AppColors.greyText,
            fontSize: AppFonts.t5
          )
        ),
        icon: Center(child: Image.asset(AppImages.arrowDown,scale: 4)),
        items: items,
        onChanged: onChanged,
        value: dropDownValue,
      ),
    );
  }
}
