import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/navigation.dart';
import 'package:taswqly/components/style/colors.dart';
import 'package:taswqly/components/style/size.dart';
import 'package:taswqly/generated/locale_keys.g.dart';
import '../../../components/custom_loading.dart';
import '../../../components/style/images.dart';
import '../components/delete_popup.dart';
import '../components/item_notify.dart';
import '../controller/notification_cubit.dart';
import '../controller/notification_states.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit()..fetchNotifications(context: context),
      child: BlocBuilder<NotificationCubit, NotificationStates>(
          builder: (context, state) {
        final cubit = NotificationCubit.get(context);
        return SafeArea(
          bottom: false,
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width(context) * 0.04,
                  vertical: height(context) * 0.03),
              child:
              state is NotificationsLoadingState?  SizedBox(height: height(context)*0.85,child: const CustomLoading()):Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cubit.notificationsModel!.data!.day!.isNotEmpty||cubit.notificationsModel!.data!.yesterday!.isNotEmpty?Row(
                      children: [
                    GestureDetector(
                        onTap: () {
                          navigatorPop(context: context);
                        },
                        child: Image.asset(
                            context.locale.languageCode == "ar"
                                ? AppImages.arrowAR
                                : AppImages.arrowEN,
                            scale: 3.7)),
                    const Spacer(),
                    CustomText(
                        text: LocaleKeys.Notification.tr(),
                        color: AppColors.textColor,
                        fontSize: AppFonts.t2),
                    const Spacer(),
                    DeleteItem(onTap: () {
                      cubit.deleteAllNotify(context: context);
                    }),
                  ]):Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              navigatorPop(context: context);
                            },
                            child: Image.asset(
                                context.locale.languageCode == "ar"
                                    ? AppImages.arrowAR
                                    : AppImages.arrowEN,
                                scale: 3.7)),
                        const Spacer(flex: 3),
                        CustomText(
                            text: LocaleKeys.Notification.tr(),
                            color: AppColors.textColor,
                            fontSize: AppFonts.t2),
                        const Spacer(flex: 4),
                      ]),
                  SizedBox(height: height(context) * 0.05),
                  cubit.notificationsModel!.data!.day!.isEmpty&&cubit.notificationsModel!.data!.yesterday!.isEmpty ? Expanded(
                    child: Center(
                      child: CustomText(
                          text: LocaleKeys.NotifyEmpty.tr(),
                          fontSize: AppFonts.t2,
                          color: AppColors.textOrange,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ):Expanded(
                      child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                cubit.notificationsModel!.data!.day!.isEmpty?
                                const SizedBox.shrink():CustomText(
                                text: LocaleKeys.Today.tr(),
                                color: AppColors.greyText,
                                fontSize: AppFonts.t4,
                                fontWeight: FontWeight.w500),
                            SizedBox(height: height(context) * 0.02),
                            cubit.notificationsModel!.data!.day!.isEmpty?
                            const SizedBox.shrink():
                            ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                     Slidable(
                                       endActionPane: ActionPane(
                                           motion: const BehindMotion(),
                                           children: [
                                             Expanded(
                                               child: Align(
                                                 alignment: Alignment.centerRight,
                                                 child: InkWell(
                                                   onTap: () {
                                                     cubit.deleteNotify(context: context, id: cubit.notificationsModel!.data!.day![index].id!,today: true);
                                                   },
                                                   borderRadius: BorderRadius.circular(16),
                                                   child: Container(
                                                       alignment: Alignment.center,
                                                       width: width(context)*0.2,
                                                       decoration: BoxDecoration(
                                                           color: Color(0xffD13526),
                                                           borderRadius: BorderRadius.circular(10)),
                                                       child: Image.asset(AppImages.clear,width: width(context)*0.07,color: Colors.white,)),
                                                 ),
                                               ),
                                             ),
                                           ]),
                                       child: ItemNotify(
                                           isOnline: false,
                                       notifyTime: cubit.notificationsModel!.data!.day![index].date,
                                         notifyBody: cubit.notificationsModel!.data!.day![index].body,
                                         image: cubit.notificationsModel!.data!.day![index].photo,
                                       ),
                                     ),
                                separatorBuilder: (context, index) => SizedBox(height: height(context) * 0.015),
                                itemCount: cubit.notificationsModel!.data!.day!.length),
                            SizedBox(height: height(context) * 0.03),
                                cubit.notificationsModel!.data!.yesterday!.isEmpty? const SizedBox.shrink():CustomText(
                                text: LocaleKeys.Yesterday.tr(),
                                color: AppColors.greyText,
                                fontSize: AppFonts.t4,
                                fontWeight: FontWeight.w500),
                            SizedBox(height: height(context) * 0.02), cubit.notificationsModel!.data!.yesterday!.isEmpty? const SizedBox.shrink():
                            ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    Slidable(
                                       endActionPane: ActionPane(
                                          motion: const BehindMotion(),
                                          children: [
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: InkWell(
                                                  onTap: () {
                                                    cubit.deleteNotify(context: context, id: cubit.notificationsModel!.data!.yesterday![index].id!,today: false);
                                                  },
                                                  borderRadius: BorderRadius.circular(16),
                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      width: width(context)*0.2,
                                                      decoration: BoxDecoration(
                                                          color: const Color(0xffD13526),
                                                          borderRadius: BorderRadius.circular(10)),
                                                      child: Image.asset(AppImages.clear,width: width(context)*0.07,color: Colors.white,)),
                                                ),
                                              ),
                                            ),
                                          ]),
                                       child: ItemNotify(
                                           isOnline: false,
                                       notifyBody: cubit.notificationsModel!.data!.yesterday![index].body!,
                                         notifyTime: cubit.notificationsModel!.data!.yesterday![index].date!,
                                         image: cubit.notificationsModel!.data!.yesterday![index].photo,
                                       ),
                                    ),
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: height(context) * 0.015),
                                itemCount: cubit.notificationsModel!.data!.yesterday!.length),
                          ])))
                ]
              )
            )
          )
        );
      })
    );
  }
}
