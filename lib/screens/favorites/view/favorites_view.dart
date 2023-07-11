import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/screens/favorites/components/item_fav.dart';
import '../../../components/custom_loading.dart';
import '../../../components/custom_text.dart';
import '../../../components/navigation.dart';
import '../../../components/style/colors.dart';
import '../../../components/style/images.dart';
import '../../../components/style/size.dart';
import '../../../generated/locale_keys.g.dart';
import '../controller/favorites_cubit.dart';
import '../controller/favorites_states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesCubit()..fetchfav(context: context),
      child: BlocBuilder<FavoritesCubit, FavoritesStates>(
          builder: (context, state) {
            final cubit = FavoritesCubit.get(context);
            return SafeArea(
              bottom: false,
              child: Scaffold(
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width(context)*0.03,vertical: height(context)*0.02),
                  child:
                    Column(
                    children: [
                      Row(children: [
                        GestureDetector(
                            onTap: () {
                              navigatorPop(context: context);
                            },
                            child: Image.asset(
                                context.locale.languageCode == "ar"
                                    ? AppImages.arrowAR
                                    : AppImages.arrowEN,
                                scale: 3.7)),
                        SizedBox(width: width(context)*0.255),
                        CustomText(
                            text: LocaleKeys.Favorites.tr(),
                            color: AppColors.textColor,
                            fontSize: AppFonts.t2),

                      ]),
                      SizedBox(height: height(context)*0.035),
                      state is FavoritesLoadingState ? const Expanded(child: CustomLoading()) :cubit.favoutiresModel!.data!.isEmpty?
                      Expanded(
                          child: Center(
                            child: CustomText(
                              text: LocaleKeys.EmptyFav.tr(),
                              fontSize: AppFonts.t3,
                              color: AppColors.textOrange,
                              fontWeight: FontWeight.bold,
                            ),
                          )):Expanded(
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context,index)=> ItemFav(
                                  text: cubit.favoutiresModel!.data![index].name!,
                                  onFav: (){
                                    cubit.toggleFav(context: context, id: cubit.favoutiresModel!.data![index].id!);
                                  },
                                  image: cubit.favoutiresModel!.data![index].photo!,
                                  subTitle: cubit.favoutiresModel!.data![index].category!,
                                  rate: double.parse(cubit.favoutiresModel!.data![index].rates!),
                                  textTime: ""
                              ),
                              separatorBuilder: (context,index)=> SizedBox(height: height(context)*0.02),
                              itemCount: cubit.favoutiresModel!.data!.length))
                    ],
                  ),
                )
              )
            );
          }),
    );
  }
}
