import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../components/custom_text.dart';
import '../../../../components/style/images.dart';
import '../../../../components/style/size.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../components/style/colors.dart';

class DeleteItem extends StatelessWidget {
  final Function()? onTap;
  const DeleteItem({Key? key, required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7)
      ),
      color: AppColors.notifyColor,
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            onTap: onTap,
            padding:EdgeInsets.symmetric(horizontal: width(context)*0.015),
            child: Center(
              child: SizedBox(
                width: width(context)*0.3,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImages.clear, scale: 3.5),
                    SizedBox(
                        width: width(context) * 0.03
                    ),
                    CustomText(
                        text: LocaleKeys.DeleteAll.tr(),
                        color: AppColors.textColor,
                    fontSize: AppFonts.t6)
                  ]
                )
              )
            )
          )
        ];
      },
      child: Image.asset(AppImages.menu, scale: 4)
    );

  }
}
