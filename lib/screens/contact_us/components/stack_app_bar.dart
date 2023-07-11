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

class StackAppBarContact extends StatelessWidget {
  final ContactUsCubit cubit;

  const StackAppBarContact({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.topStart, children: [
      Container(
          height: height(context) * 0.42,
          decoration: const BoxDecoration(
              color: AppColors.textColor,
              image: DecorationImage(
                  image: AssetImage(AppImages.appBar), fit: BoxFit.cover),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15)))),
      Image.asset(AppImages.shadoww, fit: BoxFit.cover),
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
                  text: LocaleKeys.ContactUs.tr(),
                  color: AppColors.whiteColor,
                  fontSize: AppFonts.t2),
              const Spacer(flex: 4),
            ]),
          ),
          GestureDetector(
            onTap: () async {
              final Uri launchUri = Uri(
                scheme: 'tel',
                path: cubit.contactUsModel!.data!.phone,
              );
              await launchUrl(launchUri);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width(context) * 0.05,
                  vertical: height(context) * 0.005),
              child: Row(children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: width(context) * 0.027,
                      vertical: height(context) * 0.015),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.whiteColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                      child: Image.asset(AppImages.iphoneContact, scale: 3)),
                ),
                SizedBox(width: width(context) * 0.02),
                CustomText(
                    text: cubit.contactUsModel!.data!.phone!,
                    color: AppColors.whiteColor,
                    fontSize: AppFonts.t3),
              ]),
            ),
          ),
          GestureDetector(
            onTap: () async {
              final url = Uri(
                  scheme: 'mailto',
                  path: cubit.contactUsModel!.data!.email!,
                  query: cubit.encodeQueryParameters(<String, String>{}));
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width(context) * 0.05,
                  vertical: height(context) * 0.005),
              child: Row(children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: width(context) * 0.03,
                      vertical: height(context) * 0.015),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.whiteColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                      child: Image.asset(AppImages.emailContact, scale: 3)),
                ),
                SizedBox(width: width(context) * 0.02),
                CustomText(
                    text: cubit.contactUsModel!.data!.email!,
                    color: AppColors.whiteColor,
                    fontSize: AppFonts.t3),
              ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width(context) * 0.05,
                vertical: height(context) * 0.005),
            child: Row(children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width(context) * 0.03,
                    vertical: height(context) * 0.015),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.whiteColor),
                    borderRadius: BorderRadius.circular(8)),
                child:
                    Center(child: Image.asset(AppImages.markContact, scale: 3)),
              ),
              SizedBox(width: width(context) * 0.02),
              CustomText(
                  text: cubit.contactUsModel!.data!.address!,
                  color: AppColors.whiteColor,
                  fontSize: AppFonts.t3),
            ]),
          ),
        ],
      ),
    ]);
  }
}
