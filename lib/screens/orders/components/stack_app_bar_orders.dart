import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taswqly/screens/orders/controller/orders_cubit.dart';
import '../../../components/custom_text.dart';
import '../../../components/navigation.dart';
import '../../../components/style/colors.dart';
import '../../../components/style/images.dart';
import '../../../components/style/size.dart';
import '../../../generated/locale_keys.g.dart';

class StackAppBarOrders extends StatelessWidget {
  final OrdersCubit cubit;

  const StackAppBarOrders({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
      Container(
          height: height(context) * 0.31,
          width: width(context),
          decoration: const BoxDecoration(
            color: AppColors.textColor,
              image: DecorationImage(
                  image: AssetImage(AppImages.appBar), fit: BoxFit.cover),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15)))),
      Image.asset(AppImages.shadoww, fit: BoxFit.fill),
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
              SizedBox(width: width(context) * 0.26),
              CustomText(
                  text: LocaleKeys.MyOrders.tr(),
                  color: AppColors.whiteColor,
                  fontSize: AppFonts.t2),
            ]),
          ),
          SizedBox(height: height(context)*0.075),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: width(context)*0.09),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                cubit.names.length,
                (index) => GestureDetector(
                  onTap: () {
                    cubit.changeBottom(index);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width(context) * 0.05,
                        vertical: height(context) * 0.01),
                    decoration: cubit.currentIndex == index
                        ? BoxDecoration(
                            border: Border.all(color: AppColors.textOrange),
                            borderRadius: BorderRadius.circular(8))
                        : null,
                    child: Center(
                      child: Padding(
                        padding:  EdgeInsetsDirectional.only(start: width(context)*0.0001,top: height(context)*0.006),
                        child: CustomText(
                            text: cubit.names[index],
                            textAlign: TextAlign.center,
                            color: cubit.currentIndex == index
                                ? AppColors.textOrange
                                : AppColors.whiteColor,
                            fontSize: AppFonts.t3),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}
