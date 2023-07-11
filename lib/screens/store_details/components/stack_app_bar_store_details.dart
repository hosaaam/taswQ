import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taswqly/screens/order_details/controller/orders_details_cubit.dart';
import 'package:taswqly/screens/orders/controller/orders_cubit.dart';
import 'package:taswqly/screens/product_details/controller/product_details_cubit.dart';
import 'package:taswqly/screens/store_details/controller/store_details_cubit.dart';
import '../../../components/custom_text.dart';
import '../../../components/navigation.dart';
import '../../../components/style/colors.dart';
import '../../../components/style/images.dart';
import '../../../components/style/size.dart';
import '../../../generated/locale_keys.g.dart';

class StackAppBarStoreDetails extends StatelessWidget {
  final StoreDetailsCubit cubit;
  final ValueChanged<String> valueChanged ;

  const StackAppBarStoreDetails({Key? key, required this.cubit, required this.valueChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Container(
              height: height(context) * 0.35,
              width: width(context),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(cubit.storeDetailsModel!.data!.photo!), fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)))),
          // Image.asset(AppImages.shadoww, fit: BoxFit.fill),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width(context) * 0.03,
                    vertical: height(context) * 0.03),
                child: Row(children: [
                  GestureDetector(
                      onTap: () {
                        valueChanged.call('');
                        navigatorPop(context: context);
                      },
                      child: Image.asset(
                          context.locale.languageCode == "ar"
                              ? AppImages.arrowARWhite
                              : AppImages.arrowENWhite,
                          scale: 3.7)),
                ]),
              ),
            ],
          ),
        ]);
  }
}
