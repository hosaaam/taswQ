import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taswqly/screens/contact_us/controller/contact_us_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../components/custom_text.dart';
import '../../../components/navigation.dart';
import '../../../components/style/colors.dart';
import '../../../components/style/images.dart';
import '../../../components/style/size.dart';
import '../../../generated/locale_keys.g.dart';

class StackAppBarOrderDetails extends StatelessWidget {
  const StackAppBarOrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.topStart, children: [
      Container(
          height: height(context) * 0.25,
          decoration: const BoxDecoration(
            color: AppColors.textColor,
            image: DecorationImage(
                image: AssetImage(AppImages.appBar), fit: BoxFit.cover),
          )),
      Image.asset(AppImages.shadoww,
          fit: BoxFit.fill,
          height: height(context) * 0.25,
          width: width(context)),
      Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width(context) * 0.03,
                vertical: height(context) * 0.03),
            child: Row(children: [
              GestureDetector(
                  onTap: () {
                    navigatorPop(context: context);
                  },
                  child: Image.asset(
                      context.locale.languageCode == "ar"
                          ? AppImages.arrowARWhite
                          : AppImages.arrowENWhite,
                      scale: 3.7)),
              const Spacer(flex: 3),
              CustomText(
                text: LocaleKeys.DetailsOrder.tr(),
                color: AppColors.whiteColor,
                fontSize: AppFonts.t1,
              ),
              const Spacer(flex: 4),
            ]),
          ),
        ],
      ),
    ]);
  }
}
