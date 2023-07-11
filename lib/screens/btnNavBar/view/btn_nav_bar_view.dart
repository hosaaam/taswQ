import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/components/style/colors.dart';
import 'package:taswqly/components/style/images.dart';
import 'package:taswqly/components/style/size.dart';
import 'package:taswqly/components/visitor_dialog.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/generated/locale_keys.g.dart';
import 'package:taswqly/screens/btnNavBar/controller/btn_nav_bar_cubit.dart';
import 'package:taswqly/screens/btnNavBar/controller/btn_nav_bar_states.dart';
import 'package:taswqly/screens/scan/view/scanQr_code.dart';
import 'package:taswqly/shared/local/cache_helper.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBarCubit(),
      child: BlocBuilder<BottomNavBarCubit, BottomNavBarStates>(
          builder: (context, state) {
            final cubit = BottomNavBarCubit.get(context);
            return KeyboardDismissOnTap(
              child: KeyboardVisibilityBuilder(builder: (context, visible) {
                return SafeArea(
                bottom: false,
                child: Scaffold(
                  /// Btn Nav New
                    body: cubit.btnWidget[cubit.currentIndex],
                    backgroundColor: Colors.white,
                    bottomNavigationBar: BottomNavigationBar(
                      items: [
                        BottomNavigationBarItem(
                            label: LocaleKeys.Home.tr(),
                            icon: Padding(
                                padding: EdgeInsetsDirectional.only(bottom: height(context)*0.013),
                                child: Image.asset(cubit.currentIndex == 0?AppImages.homeSelect:AppImages.home, scale: 3))),
                        BottomNavigationBarItem(
                            label: LocaleKeys.Stores.tr(),
                            icon: Padding(
                                padding: EdgeInsetsDirectional.only(bottom: height(context)*0.013),
                                child: Image.asset(cubit.currentIndex == 1 ?AppImages.storeSelect:AppImages.store, scale: 3))),
                        BottomNavigationBarItem(
                            icon: Column(children: [SizedBox(height: height(context)*0.045),
                              CustomText(text: LocaleKeys.ScanTheBarcode.tr(),color: AppColors.textColor,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  fontSize: AppFonts.t6)
                            ]),label: ''),
                        BottomNavigationBarItem(
                            label: LocaleKeys.Cart.tr(),
                            icon:  Padding(
                                padding: EdgeInsetsDirectional.only(bottom: height(context)*0.013),
                                child: Image.asset(cubit.currentIndex == 3 ?AppImages.cartSelect:AppImages.cart, scale: 3))),
                        BottomNavigationBarItem(
                            label: LocaleKeys.More.tr(),
                            icon: Padding(
                                padding: EdgeInsetsDirectional.only(bottom: height(context)*0.03,top: height(context)*0.013),
                                child: Image.asset(cubit.currentIndex == 4?AppImages.moreSelect:AppImages.more, scale: 3))),
                      ],
                      type: BottomNavigationBarType.fixed,
                      onTap: (int index) {
                        if(index == 2){
                          CacheHelper.getData(key: AppCached.userToken)==null ? showDialog(context: context, builder: (context)=>const VisitorDialog()):navigateTo(context:context, widget: const ScanQrCode());
                          // navigateTo(context:context, widget:const ProductDetailsScreen());
                        }else if (index==3){
                          CacheHelper.getData(key: AppCached.userToken)==null ? showDialog(context: context, builder: (context)=>const VisitorDialog()): cubit.changePage(index:index,context: context);
                          }else{
                          cubit.changePage(index:index,context: context);
                        }
                      },
                      currentIndex: cubit.currentIndex,
                      selectedItemColor: AppColors.textColor,
                      elevation: 5,
                      selectedLabelStyle: TextStyle(color: AppColors.textColor,fontSize: AppFonts.t6),
                      backgroundColor: Colors.white,
                    ),
                    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                    floatingActionButton:  visible ? null :FloatingActionButton(
                        backgroundColor: Colors.transparent,
                        onPressed: (){
                          // navigateTo(context:context, widget: const ProductDetailsScreen());
                          CacheHelper.getData(key: AppCached.userToken)==null ? showDialog(context: context, builder: (context)=>const VisitorDialog()):navigateTo(context:context, widget: const ScanQrCode());
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: width(context)*0.03,vertical: height(context)*0.02),
                            decoration:const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(AppImages.barCodeBG)
                                )),
                            child: Image.asset(AppImages.barCode,scale: 3.5)))
                  /// Btm Nav Old
                  // body: btnWidget[currentIndex],
                  // bottomNavigationBar: Stack(
                  //   children: [
                  //     BottomAppBar(
                  //       color: AppColors.whiteColor,
                  //       shape: const CircularNotchedRectangle(),
                  //       notchMargin: width(context) * 0.035,
                  //       clipBehavior: Clip.antiAliasWithSaveLayer,
                  //       elevation: 20,
                  //       child: SizedBox(
                  //         height: height(context)*0.09,
                  //           child: Row(
                  //             children: [
                  //               context.locale.languageCode=="ar"?SizedBox(width: width(context)*0.015):SizedBox(width: width(context)*0.023),
                  //               Expanded(
                  //                 child: Row(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //                   children: [
                  //                     InkWell(
                  //                       onTap: () {
                  //                         setState(() {
                  //                           currentIndex = 0;
                  //                         });
                  //                       },
                  //                       child: Column(
                  //                         children: [
                  //                           SizedBox(
                  //                               height: height(context) * 0.01
                  //                           ),
                  //                           InkWell(
                  //                             onTap: () {
                  //                               setState(() {
                  //                                 currentIndex = 0;
                  //                               });
                  //                             },
                  //                                 child: Image.asset(currentIndex != 0 ?AppImages.home:AppImages.homeSelect,
                  //                                 width: width(context) * 0.06),
                  //                               ),
                  //                           const Spacer(),
                  //                           CustomText(
                  //                             text: LocaleKeys.Home.tr(),
                  //                             color: currentIndex != 0
                  //                                 ? AppColors.greyText
                  //                                 : AppColors.textColor,
                  //                             fontSize: AppFonts.t6
                  //                           ),
                  //                           SizedBox(
                  //                             height: height(context) * 0.01
                  //                           )
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                         width: width(context) * 0.05
                  //                     ),
                  //                     InkWell(
                  //                       onTap: () {
                  //                         setState(() {
                  //                          currentIndex = 1;
                  //                         });
                  //                       },
                  //                       child: Column(
                  //                         children: [
                  //                           SizedBox(
                  //                             height: height(context) * 0.01
                  //                           ),
                  //                           InkWell(
                  //                             onTap: () {
                  //                               setState(() {
                  //                                 currentIndex = 1;
                  //                               });
                  //                             },
                  //                                 child: Image.asset(currentIndex != 1 ? AppImages.store:AppImages.storeSelect,
                  //                                 width: width(context) * 0.065),
                  //                               ),
                  //                           const Spacer(),
                  //                           CustomText(
                  //                             text: LocaleKeys.Stores.tr(),
                  //                             color: currentIndex != 1
                  //                                 ? AppColors.greyText
                  //                                 : AppColors.textColor,
                  //                             fontSize: AppFonts.t6
                  //                           ),
                  //                           SizedBox(
                  //                             height: height(context) * 0.01
                  //                           )
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                         width: width(context) * 0.025
                  //                     )
                  //                   ],
                  //                 )
                  //               ),
                  //               Column(
                  //                 children: [
                  //                   SizedBox(height: height(context)*0.05),
                  //                   CustomText(text: LocaleKeys.ScanTheBarcode.tr(),color: AppColors.textColor,
                  //                   fontSize: AppFonts.t6)
                  //                 ],
                  //               ),
                  //               Expanded(
                  //                 child: Row(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //                   children: [
                  //
                  //                     InkWell(
                  //                       onTap: () {
                  //                         setState(() {
                  //                           currentIndex = 2;
                  //                         });
                  //                       },
                  //                       child: Column(
                  //                         children: [
                  //                           SizedBox(
                  //                             height: height(context) * 0.01
                  //                           ),
                  //                           InkWell(
                  //                             onTap: () {
                  //                               setState(() {
                  //                                 currentIndex = 2;
                  //                               });
                  //                             },
                  //                                 child: Image.asset( currentIndex != 2?AppImages.cart:AppImages.cartSelect,
                  //                                 width: width(context) * 0.06)
                  //                               ),
                  //                           const Spacer(),
                  //                           CustomText(
                  //                               text: LocaleKeys.Cart.tr(),
                  //                               color: currentIndex != 2
                  //                                   ? AppColors.greyText
                  //                                   : AppColors.textColor,
                  //                               fontSize: AppFonts.t6),
                  //                           SizedBox(
                  //                             height: height(context) * 0.01
                  //                           )
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                         width: width(context) * 0.005
                  //                     ),
                  //                     InkWell(
                  //                       onTap: () {
                  //                         setState(() {
                  //                           currentIndex = 3;
                  //                         });
                  //                       },
                  //                       child: Column(
                  //                         children: [
                  //
                  //                           SizedBox(
                  //                             height: height(context) * 0.02
                  //                           ),
                  //                           InkWell(
                  //                             onTap: () {
                  //                               setState(() {
                  //                                 currentIndex = 3;
                  //                               });
                  //                             },
                  //                                 child: Image.asset(currentIndex != 3 ?AppImages.more:AppImages.moreSelect,
                  //                                 width: width(context) * 0.06),
                  //                               ),
                  //                           const Spacer(),
                  //                           CustomText(
                  //                               text: LocaleKeys.More.tr(),
                  //                               color: currentIndex != 3
                  //                                   ? AppColors.greyText
                  //                                   : AppColors.textColor,
                  //                               fontSize: AppFonts.t6),
                  //                           SizedBox(
                  //                             height: height(context) * 0.01
                  //                           )
                  //                         ],
                  //                       ),
                  //                     )
                  //                   ],
                  //                 )
                  //               )
                  //             ]
                  //           ))
                  //     ),
                  //     Positioned(
                  //       right: width(context)*0.417,
                  //       child: InkWell(
                  //         onTap: (){
                  //           navigateTo(context, const ProductDetailsScreen());
                  //         },
                  //         child: Transform.translate(
                  //           offset: context.locale.languageCode=="ar"?const Offset(0,-35):const Offset(3,-35),
                  //           child: Container(
                  //             padding: EdgeInsets.symmetric(horizontal: width(context)*0.03,vertical: height(context)*0.02),
                  //             decoration:const BoxDecoration(
                  //                 image: DecorationImage(
                  //                     image: AssetImage(AppImages.barCodeBG)
                  //                 )
                  //             ),
                  //             child: Image.asset(AppImages.barCode,scale: 3.5),
                  //           ),
                  //         ),
                  //       ),
                  //     )
                  //
                  //   ],
                  // ),
                ),
              );
              }));
          }),
    );
  }
}
