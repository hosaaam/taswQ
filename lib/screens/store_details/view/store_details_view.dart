import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:taswqly/components/custom_button.dart';
import 'package:taswqly/components/custom_loading.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/custom_textfield.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/components/visitor_dialog.dart';
import 'package:taswqly/core/local/app_cached.dart';
import 'package:taswqly/generated/locale_keys.g.dart';
import 'package:taswqly/screens/home/components/rating_bar.dart';
import 'package:taswqly/screens/store_details/components/item_rate.dart';
import 'package:taswqly/screens/store_details/components/rate_dialog.dart';
import 'package:taswqly/screens/store_details/components/stack_app_bar_store_details.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/style/colors.dart';
import '../../../components/style/images.dart';
import '../../../components/style/size.dart';
import '../../../shared/local/cache_helper.dart';
import '../controller/store_details_cubit.dart';
import '../controller/store_details_states.dart';

class StoreDetailsScreen extends StatelessWidget {
  final int id;
  final ValueChanged<String?> valueChanged;
  const StoreDetailsScreen({super.key,  required this.id,required this.valueChanged});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        valueChanged.call('');
        return true;
      },
      child: BlocProvider(
        create: (context) => StoreDetailsCubit()..fetchStoreDetails(context: context, id: id),
        child: BlocBuilder<StoreDetailsCubit, StoreDetailsStates>(
            builder: (context, state) {
          final cubit = StoreDetailsCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: state is StoreDetailsLoadingState?
                SizedBox(
                    height: height(context)*0.85,
                    child: const CustomLoading()):
                Column(
                  children: [
                    StackAppBarStoreDetails(cubit: cubit,valueChanged: valueChanged),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width(context) * 0.03,
                          vertical: height(context) * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height(context) * 0.01),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: width(context)*0.5,
                                      child: CustomText(
                                          text: cubit.storeDetailsModel!.data!.name!,
                                          color: AppColors.textColor,
                                          fontSize: AppFonts.t3),
                                    ),
                                    SizedBox(height: height(context) * 0.005),
                                    RatingBarItem(
                                        rate: double.parse(cubit.storeDetailsModel!.data!.rate!), itemSize: width(context) * 0.06),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () async{
                                        var uri = Uri.parse("google.navigation:q=${cubit.storeDetailsModel!.data!.lat},${cubit.storeDetailsModel!.data!.lng}&mode=d");
                                        if (await canLaunch(uri.toString())) {
                                          await launch(uri.toString());
                                        } else {
                                          throw 'Could not launch ${uri.toString()}';
                                        } },
                                      child: Icon(Icons.location_on_outlined,size: width(context)*0.08,color: Colors.grey.shade400),
                                    ),
                                    SizedBox(width: width(context)*0.02,),
                                    GestureDetector(
                                      onTap: () async{
                                        await Share.share(cubit.storeDetailsModel!.data!.shareLink!);
                                      },
                                      child: Image.asset(AppImages.share,
                                          scale: 3.5),
                                    ),
                                    CacheHelper.getData(key: AppCached.userToken)!=null ?SizedBox(width: width(context) * 0.04):const SizedBox.shrink(),
                                    CacheHelper.getData(key: AppCached.userToken)!=null ?GestureDetector(
                                      onTap: () {
                                        cubit.toggleFav(context: context, id: id);
                                      },
                                      child: Image.asset(
                                          cubit.storeDetailsModel!.data!.isFavorite==true?
                                          AppImages.fav : AppImages.unFav, scale: 3.5),
                                    ):const SizedBox.shrink(),
                                    SizedBox(width: width(context) * 0.04),
                                    CacheHelper.getData(key: AppCached.userToken)!=null ?GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context)=> AlertDialog(
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CustomText(
                                                    text: LocaleKeys.SendReport.tr(),
                                                    color: AppColors.textColor,
                                                    fontSize: AppFonts.t3),
                                                SizedBox(height: height(context)*0.04,),
                                                CustomTextFormField(
                                                  ctrl: cubit.reportCtrl,
                                                maxLines: 4,
                                                contentPadding: EdgeInsets.symmetric(horizontal: width(context)*0.03),
                                                ),
                                                SizedBox(height: height(context)*0.02,),
                                                state is AddRateLoadingState?
                                                CustomLoading():
                                                CustomButton(
                                                    text: LocaleKeys.Send.tr(),
                                                    onPressed: (){
                                                      cubit.addReport(context: context, id: cubit.storeDetailsModel!.data!.id!);
                                                    },
                                                    isOrange: false)
                                              ],
                                            ),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                            ));
                                          },
                                      child: Image.asset(AppImages.report,
                                          scale: 3.5),
                                    ):const SizedBox.shrink(),
                                  ],
                                ),
                              ]),
                          SizedBox(height: height(context) * 0.03),
                          cubit.storeDetailsModel!.data!.pio == null ? const SizedBox.shrink():CustomText(
                              text: cubit.storeDetailsModel!.data!.pio!,
                              color: AppColors.greyText,
                              fontSize: AppFonts.t6),
                          SizedBox(height: height(context) * 0.025),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: width(context) * 0.035,
                                vertical: height(context) * 0.02),
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(AppImages.clock, scale: 3),
                                SizedBox(width: width(context) * 0.01),
                                CustomText(
                                    text: "${LocaleKeys.TimesOfWork.tr()} : ",
                                    color: AppColors.textColor,
                                    fontSize: AppFonts.t5),
                                SizedBox(width: width(context) * 0.005),
                                Expanded(
                                    child: CustomText(
                                        text: "${LocaleKeys.From.tr()} ${cubit.storeDetailsModel!.data!.timeFrom!} ${LocaleKeys.To.tr()} ${cubit.storeDetailsModel!.data!.timeTo}",
                                        color: AppColors.greyText,
                                        fontSize: AppFonts.t6)),
                              ],
                            ),
                          ),
                          cubit.storeDetailsModel!.data!.offers!.isEmpty ?
                          SizedBox.shrink():
                          SizedBox(height: height(context) * 0.03),
                          cubit.storeDetailsModel!.data!.offers!.isEmpty ?
                          SizedBox.shrink():
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
                            items: List.generate(cubit.storeDetailsModel!.data!.offers!.length,
                                  (index) => InkWell(
                                    onTap: ()async{
                                      print(cubit.storeDetailsModel!.data!.offers![index].link!);
                                      if (!await launchUrl(Uri.parse(cubit.storeDetailsModel!.data!.offers![index].link!),
                                      )) {
                                      throw 'Could not launch https://tasawqly.elkhayal.co/register';
                                      }
                                      //navigateTo(context:context, widget:const RegisterScreen());
                                    },
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          cubit.storeDetailsModel!.data!.offers![index].photo!,
                                          height: height(context) * 0.23,
                                          width: width(context)*0.9,
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                            ),
                          ),
                          cubit.storeDetailsModel!.data!.offers!.isEmpty ?
                          SizedBox.shrink():
                          SizedBox(height: height(context)*0.015),
                          cubit.storeDetailsModel!.data!.offers!.isEmpty || state is StoreDetailsLoadingState?
                          SizedBox.shrink():
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate( cubit.storeDetailsModel!.data!.offers!.length, (index) {
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
                          SizedBox(height: height(context) * 0.05),
                          cubit.storeDetailsModel!.data!.rates!.isEmpty? const SizedBox.shrink():
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: CustomText(
                                      text: "${LocaleKeys.Comments.tr()} : ",
                                      color: AppColors.textColor,
                                      fontSize: AppFonts.t4)),
                              SizedBox(height: height(context)*0.02),
                              SizedBox(
                                height: height(context)*0.5,
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) =>  ItemRate(
                                        name: cubit.storeDetailsModel!.data!.rates![index].name?? "",
                                        image: cubit.storeDetailsModel!.data!.rates![index].photo!,
                                        comment: cubit.storeDetailsModel!.data!.rates![index].comment??"",
                                        date: cubit.storeDetailsModel!.data!.rates![index].commentTime!,
                                        rate: double.parse(cubit.storeDetailsModel!.data!.rates![index].rate!)),
                                    separatorBuilder: (context, index) => SizedBox(height: height(context) * 0.02),
                                    itemCount: cubit.storeDetailsModel!.data!.rates!.length),
                              ),
                              SizedBox(height: height(context)*0.01),
                            ],
                          ),
                          InkWell(
                            onTap: (){
                              CacheHelper.getData(key: AppCached.userToken)!=null ?showDialog(context: context,builder: (context)=> StatefulBuilder(
                                  builder: (context, setState) => RateDialog(
                                      onPressed: (){
                                        cubit.addRate(context: context, id: id);
                                // navigatorPop(context: context);
                              },commentCtrl: cubit.commentCtrl,rate: cubit.rate, onRatingChanged: (val){
                                setState((){cubit.changeRate(val);});
                              }))):showDialog(context: context, builder: (context)=>const VisitorDialog());
                            },
                              borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width(context) * 0.035,
                                  vertical: height(context) * 0.02),
                              decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(AppImages.comment, scale: 3),
                                  SizedBox(width: width(context) * 0.02),
                                  CustomText(
                                      text: "${LocaleKeys.AddAComment.tr()} ...",
                                      color: AppColors.greyText,
                                      fontSize: AppFonts.t5),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: height(context)*0.02)

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
