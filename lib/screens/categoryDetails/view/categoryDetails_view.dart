
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taswqly/components/custom_loading.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/custom_textfield.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/components/style/colors.dart';
import 'package:taswqly/components/style/images.dart';
import 'package:taswqly/components/style/size.dart';
import 'package:taswqly/generated/locale_keys.g.dart';
import 'package:taswqly/screens/categoryDetails/controller/categoryDetails_cubit.dart';
import 'package:taswqly/screens/categoryDetails/controller/categoryDetails_states.dart';
import 'package:taswqly/screens/store/components/item_result.dart';
import 'package:taswqly/screens/store_details/view/store_details_view.dart';

class CategoryDetailsScreen extends StatelessWidget {
final int id;

  const CategoryDetailsScreen({ required this.id});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatDetailsCubit()..filter(context: context,id: id),
      child: BlocBuilder<CatDetailsCubit, CatDetailsStates>(
          builder: (context, state) {
        final cubit = CatDetailsCubit.get(context);
        return SafeArea(
          child: Scaffold(
              body: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width(context) * 0.04,
                      vertical: height(context) * 0.03),
                  child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: CustomTextFormField(
                                  maxLines: 1,
                                  type: TextInputType.text,
                                  hint: LocaleKeys.FindAStore.tr(),
                                  prefixIcon:
                                  state is SearchLoadingState?
                                  CustomLoading():
                                  GestureDetector(
                                    child: Image.asset(AppImages.search, scale: 3.5),
                                    onTap: (){
                                      FocusScope.of(context).unfocus();
                                      cubit.search(context: context);
                                    },
                                  ),
                                  ctrl: cubit.searchCtrl,

                                )),
                            SizedBox(width: width(context) * 0.025),
                          ],
                        ),
                        SizedBox(height: height(context) * 0.025),
                        state is CategoriesLoadingState?
                        SizedBox(
                            height: height(context)*0.5,
                            child: const CustomLoading()
                        ):
                        cubit.searchModel!=null?
                        Expanded(child:
                        cubit.searchModel!.data!.isEmpty?
                        Center(
                            child: CustomText(
                              text: LocaleKeys.EmptyStores.tr(),
                              fontSize: AppFonts.t3,
                              color: AppColors.textOrange,
                              fontWeight: FontWeight.bold,
                            )):
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => InkWell(
                              onTap: (){
                                FocusScope.of(context).unfocus();
                                print(cubit.searchModel!.data![index].id!);
                                navigateTo(
                                    context:context,
                                    widget: StoreDetailsScreen(
                                      id: cubit.searchModel!.data![index].id!,
                                      valueChanged: (v){cubit.filter(context: context,id: id);},
                                    ));},
                              borderRadius: BorderRadius.circular(8),
                              child: ItemResultSearch(
                                storeId: cubit.searchModel!.data![index].id!,
                                text: cubit.searchModel!.data![index].name!,
                                image: cubit.searchModel!.data![index].photo!,
                                rate: double.parse(cubit.searchModel!.data![index].rate!),
                                subTitle: cubit.searchModel!.data![index].pio == null ? "" :cubit.searchModel!.data![index].pio!,
                                isFav: cubit.searchModel!.data![index].isFavorite!,
                                onFav: (){
                                  cubit.toggleFav(
                                      context: context,
                                      id: cubit.searchModel!.data![index].id!,
                                      index: index,
                                      type: "search"
                                  );
                                },
                                // textTime: "${cubit.searchModel!.data![index].timeFrom} ${LocaleKeys.AMinute.tr()}"
                              ),
                            ),
                            separatorBuilder: (context, index) => SizedBox(height: height(context) * 0.025),
                            itemCount: cubit.searchModel!.data!.length)):
                        Expanded(
                            child:
                            cubit.filterModel!.data!.isEmpty?
                            Center(
                                child: CustomText(
                                  text: LocaleKeys.EmptyStores.tr(),
                                  fontSize: AppFonts.t3,
                                  color: AppColors.textOrange,
                                  fontWeight: FontWeight.bold,
                                )): ListView.separated(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) => InkWell(
                                  onTap: (){
                                    FocusScope.of(context).unfocus();
                                    print(cubit.filterModel!.data![index].id!);
                                    navigateTo(
                                        context:context,
                                        widget: StoreDetailsScreen(
                                          id: cubit.filterModel!.data![index].id!,
                                          valueChanged: (v){cubit.filter(context: context,id: id);},
                                        ));},
                                  borderRadius: BorderRadius.circular(8),
                                  child: ItemResultSearch(
                                    storeId: cubit.filterModel!.data![index].id!,
                                    text: cubit.filterModel!.data![index].name!,
                                    image: cubit.filterModel!.data![index].photo!,
                                    rate: double.parse(cubit.filterModel!.data![index].rate!),
                                    subTitle: cubit.filterModel!.data![index].pio==null?"":cubit.filterModel!.data![index].pio!,
                                    isFav: cubit.filterModel!.data![index].isFavorite!,
                                    onFav: (){
                                      cubit.toggleFavFilter(context: context, id: cubit.filterModel!.data![index].id!, index: index);
                                    },
                                    // textTime: "${cubit.filterModel!.data![index].timeFrom} ${LocaleKeys.AMinute.tr()}"
                                  ),
                                ),
                                separatorBuilder: (context, index) => SizedBox(height: height(context) * 0.025),
                                itemCount: cubit.filterModel!.data!.length))
                      ]
                  )
              )
          ),
        );
      }),
    );
  }
}
