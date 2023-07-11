import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_loading.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/generated/locale_keys.g.dart';
import 'package:taswqly/screens/auth/login/view/login_view.dart';
import 'package:taswqly/screens/more/components/item_click.dart';
import 'package:taswqly/screens/more/components/more_item.dart';
import 'package:taswqly/shared/local/cache_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../components/style/images.dart';
import '../../../components/style/size.dart';
import '../../about_us/view/about_us_view.dart';
import '../../contact_us/view/contact_us_view.dart';
import '../../faq/view/faq_view.dart';
import '../../my_account/view/my_account_view.dart';
import '../../terms_and_cond/view/terms_and_cond_view.dart';
import '../components/details_Profile.dart';
import '../controller/more_cubit.dart';
import '../controller/more_states.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoreCubit()..getLinks(context: context),
      child: BlocBuilder<MoreCubit, MoreStates>(
          builder: (context, state) {
            final cubit = MoreCubit.get(context);
            return Scaffold(
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: width(context)*0.03,vertical: height(context)*0.03),
                  child: state is LinksLoadingState ? SizedBox(
                      height: height(context)*0.85,
                      child: const CustomLoading()):Column(
                    children: [
                     const DetailsProfile(),
                      CacheHelper.getData(key: AppCached.userToken)!=null ?MoreItem(text: LocaleKeys.MyAccount.tr(), onTap: (){navigateTo(context:context, widget:  const MyAccountScreen());}):const SizedBox.shrink(),
                      MoreItem(text: LocaleKeys.RegisterAsAMerchant.tr(), onTap: ()async{
                        if (!await launchUrl(Uri.parse("https://tasawqly.elkhayal.co/register"),
                          mode: LaunchMode.externalApplication,
                        )) {
                          throw 'Could not launch https://tasawqly.elkhayal.co/register';
                        }
                      }),
                      MoreItem(text: LocaleKeys.WhoAreWe.tr(), onTap: (){
                        navigateTo(context:context, widget: const AboutUsScreen());
                      }),
                      MoreItem(text: LocaleKeys.FAQ.tr(), onTap: (){navigateTo(context:context, widget:const FaqScreen());}),
                      MoreItem(text: LocaleKeys.TermsAndConditions.tr(), onTap: (){navigateTo(context:context, widget: const TermsAndCondScreen());}),
                      CacheHelper.getData(key: AppCached.userToken)!=null?MoreItem(text: LocaleKeys.ContactUs.tr(), onTap: (){navigateTo(context:context, widget: const ContactUsScreen());}):const SizedBox.shrink(),
                      state is LogOutLoadingState ? const CustomLoading() :MoreItem(text: CacheHelper.getData(key: AppCached.userToken)!=null?LocaleKeys.LogOut.tr():LocaleKeys.Login.tr(), onTap: ()async{
                        CacheHelper.getData(key: AppCached.userToken)!=null?
                        await cubit.logOut(context: context):
                        navigateAndFinish(context: context,widget: const LoginScreen());
                      }),
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
                    ]
                  ),
                )
              )
            );
          })
    );
  }
}
