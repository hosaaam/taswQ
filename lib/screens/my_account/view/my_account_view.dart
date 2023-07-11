import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_loading.dart';
import 'package:taswqly/screens/favorites/view/favorites_view.dart';
import 'package:taswqly/screens/more/components/details_Profile.dart';
import 'package:taswqly/screens/profile/controller/profile_cubit.dart';
import 'package:taswqly/screens/profile/view/profile_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/custom_text.dart';
import '../../../components/navigation.dart';
import '../../../components/style/colors.dart';
import '../../../components/style/images.dart';
import '../../../components/style/size.dart';
import '../../../generated/locale_keys.g.dart';
import '../../more/components/item_click.dart';
import '../../more/components/more_item.dart';
import '../../orders/view/orders_view.dart';
import '../../wallet/view/wallet_view.dart';
import '../controller/my_account_cubit.dart';
import '../controller/my_account_states.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MyAccountCubit()..getLinks(context: context),
        child: BlocBuilder<MyAccountCubit, MyAccountStates>(
            builder: (context, state) {
          final cubit = MyAccountCubit.get(context);
          return SafeArea(
              bottom: false,
              child: Scaffold(
                  body: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width(context) * 0.03,
                          vertical: height(context) * 0.03),
                      child: state is LinksLoadingState ? SizedBox(
                          height: height(context)*0.85,
                          child: const CustomLoading()):Column(children: [
                        Row(children: [
                          GestureDetector(
                              onTap: (){
                                navigatorPop(context: context);
                              },
                              child: Image.asset(
                                  context.locale.languageCode == "ar"
                                      ? AppImages.arrowAR
                                      : AppImages.arrowEN,
                                  scale: 3.7)),
                          const Spacer(flex: 3),
                          CustomText(
                              text: LocaleKeys.MyAccount.tr(),
                              color: AppColors.textColor,
                              fontSize: AppFonts.t2),
                          const Spacer(flex: 4),
                        ]),
                        SizedBox(height: height(context) * 0.035),
                        Expanded(
                            child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(children: [
                                  const DetailsProfile(),
                                  SizedBox(height: height(context) * 0.02),
                                  MoreItem(text: LocaleKeys.MyProfile.tr(),onTap: (){navigateTo(context:context, widget: const ProfileScreen());}),
                                  MoreItem(text: LocaleKeys.MyOrders.tr(),onTap: (){navigateTo(context:context, widget:const OrdersScreen());}),
                                  MoreItem(text: LocaleKeys.Favorites.tr(),onTap: (){navigateTo(context:context, widget:const FavoritesScreen());}),
                                  MoreItem(text: LocaleKeys.Wallet.tr(),onTap: (){navigateTo(context:context, widget:const WalletScreen());}),
                                  SizedBox(height: height(context)*0.04),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ItemClick(image: AppImages.facebook,onTap: ()async{
                                          if (!await launchUrl(Uri.parse(cubit.linksModel!.data!.facebookLink!),
                                            mode: LaunchMode.externalApplication,
                                          )) {
                                            throw 'Could not launch ${cubit.linksModel!.data!.facebookLink!}';
                                          }
                                        }),
                                        SizedBox(width: width(context)*0.015),
                                        ItemClick(image: AppImages.twitter,onTap: ()async{
                                          if (!await launchUrl(Uri.parse(cubit.linksModel!.data!.twitterLink!),
                                            mode: LaunchMode.externalApplication,
                                          )) {
                                            throw 'Could not launch ${cubit.linksModel!.data!.twitterLink!}';
                                          }
                                        },padding: EdgeInsets.symmetric(horizontal: width(context)*0.042,vertical: height(context)*0.02)),
                                        SizedBox(width: width(context)*0.015),
                                        ItemClick(image: AppImages.snapchat,onTap: ()async{
                                          if (!await launchUrl(Uri.parse(cubit.linksModel!.data!.snapChat!),
                                            mode: LaunchMode.externalApplication,
                                          )) {
                                            throw 'Could not launch ${cubit.linksModel!.data!.snapChat!}';
                                          }
                                        },padding: EdgeInsets.symmetric(horizontal: width(context)*0.043,vertical: height(context)*0.02)),
                                        SizedBox(width: width(context)*0.015),
                                        ItemClick(image: AppImages.instagram,onTap: ()async{
                                          if (!await launchUrl(Uri.parse(cubit.linksModel!.data!.instagramLink!),
                                            mode: LaunchMode.externalApplication,
                                          )) {
                                            throw 'Could not launch ${cubit.linksModel!.data!.instagramLink!}';
                                          }
                                        },padding: EdgeInsets.symmetric(horizontal: width(context)*0.044,vertical: height(context)*0.02))
                                      ]
                                  ),
                                  SizedBox(height: height(context)*0.025)
                                ]))),
                      ]))));
        }));
  }
}
