import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_loading.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/components/style/size.dart';
import 'package:taswqly/generated/locale_keys.g.dart';
import 'package:taswqly/screens/categoryDetails/view/categoryDetails_view.dart';
import 'package:taswqly/screens/home/components/item_list.dart';
import 'package:taswqly/screens/store_details/view/store_details_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/style/colors.dart';
import '../components/item_grid.dart';
import '../controller/home_cubit.dart';
import '../controller/home_states.dart';
import '../components/stack_app_bar_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..fetchCategories(context: context)..fetchBanners(context: context)..fetchShops(context: context),
      child: BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
        final cubit = HomeCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            // physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const StackAppBarHome(),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: width(context) * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height(context)*0.02),
                      /// -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* fetch categories  -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
                      SizedBox(
                        height: height(context)*0.08,
                        child:
                        cubit.categoriesModel==null || state is CategoriesLoadingState?
                          CustomLoading():
                        ListView.separated(
                          shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: (){
                                navigateTo(context: context, widget: CategoryDetailsScreen(id: cubit.categoriesModel!.data![index].id!));
                              },
                              child: ItemList(
                                  image: cubit.categoriesModel!.data![index].photo!,
                                  text: cubit.categoriesModel!.data![index].name!),
                            ),
                            separatorBuilder: (context, index) =>
                                SizedBox(width: width(context) * 0.015),
                            itemCount: cubit.categoriesModel!.data!.length),
                      ),
                      SizedBox(height: height(context)*0.02),
                      /// -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* fetch banners  -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
                      cubit.bannersModel==null || state is BannersLoadingState?
                      CustomLoading():
                      CarouselSlider(
                        options: CarouselOptions(
                          initialPage: cubit.numSlider,
                          onPageChanged: (index, reason) {
                            cubit.changeSlider(index);
                          },
                          autoPlay: true,
                          viewportFraction: 1,
                          height: height(context) * 0.179,
                        ),
                        items: List.generate(cubit.bannersModel!.data!.length,
                              (index) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: width(context) * 0.01),
                            child: GestureDetector(
                              onTap: ()async{
                                if (!await launchUrl(Uri.parse(cubit.bannersModel!.data![index].link!),
                                )) {
                                  throw 'Could not launch ${cubit.bannersModel!.data![index].link!}';
                                }
                              },
                              child: Image.network(cubit.bannersModel!.data![index].photo!,fit: BoxFit.fill,width: width(context)*0.9),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height(context)*0.015),
                      cubit.bannersModel==null || state is BannersLoadingState?
                      SizedBox.shrink():
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate( cubit.bannersModel!.data!.length, (index) {
                          return Container(
                            width: cubit.numSlider==index? width(context)*0.12:width(context)*0.045,
                            height: width(context)*0.014,
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: cubit.numSlider==index? AppColors.bottomColor:AppColors.greyTextField,
                              borderRadius: BorderRadius.circular(10),

                            ),
                          );
                        })
                      ),
                      SizedBox(height: height(context)*0.025),
                      CustomText(text: LocaleKeys.Stores.tr(),color: AppColors.textColor,fontSize: AppFonts.t5),
                      SizedBox(height: height(context)*0.03),
                      /// -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* fetch Shops  -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
                      cubit.shopsModel==null || state is ShopsLoadingState?
                      CustomLoading():
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: width(context) * 0.005),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1 / 1.1),
                        itemCount: cubit.shopsModel!.data!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              navigateTo(
                                  context:context,
                                  widget: StoreDetailsScreen(
                                    id: cubit.shopsModel!.data![index].id!,
                                    valueChanged: (v){
                                      cubit.fetchShops(context: context);}
                                  ))
                              ;},
                            child: ItemGrid(
                              storeId: cubit.shopsModel!.data![index].id!,
                                image: cubit.shopsModel!.data![index].photo!,
                                text: cubit.shopsModel!.data![index].name!,
                                rate: double.parse(cubit.shopsModel!.data![index].rate!),
                                textTime: ""),
                          );
                        },
                      ),
                      SizedBox(height: height(context)*0.02)


                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
