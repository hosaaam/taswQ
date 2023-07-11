import 'dart:async';
import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taswqly/components/custom_text.dart';
import 'package:taswqly/components/style/size.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/navigation.dart';
import '../../../../components/style/colors.dart';
import '../../../../components/style/images.dart';
import '../../../../generated/locale_keys.g.dart';
import '../controller/pin_code_cubit.dart';
import '../controller/pin_code_states.dart';

class PinCodeScreen extends StatefulWidget {
  final String phone ;
  const PinCodeScreen({super.key, required this.phone});

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}


class _PinCodeScreenState extends State<PinCodeScreen> {
  final interval = const Duration(seconds: 1);
  final int timerMaxSeconds = 60;
  int currentSeconds = 0;
  String get timerText => '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout() {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        debugPrint(timer.tick.toString());
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) {
          timer.cancel();
          debugPrint("Finish Timer");
        }
      });
    });
  }
  @override
  void initState() {
    startTimeout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PinCodeCubit(),
      child: BlocBuilder<PinCodeCubit, PinCodeStates>(
          builder: (context, state) {
            final cubit = PinCodeCubit.get(context);
            return SafeArea(
              bottom: false,
              child: Scaffold(
                body: Container(
                  height: height(context),
                  width: width(context),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppImages.bG), fit: BoxFit.fill)),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: height(context) * 0.05,
                          horizontal: width(context) * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: (){
                                navigatorPop(context:context);
                              },
                              child: Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Image.asset(context.locale.languageCode=="ar"?AppImages.arrowAR:AppImages.arrowEN, width: width(context) * 0.1))),
                          SizedBox(height: height(context)*0.06),
                          Image.asset(AppImages.logBlue, width: width(context) * 0.45),
                          SizedBox(height: height(context) * 0.08),
                          CustomText(
                              text: LocaleKeys.CodeActive.tr(),
                              color: AppColors.textColor,
                              fontSize: AppFonts.h4,
                              fontWeight: FontWeight.w500),
                          SizedBox(height: height(context) * 0.03),
                          CustomText(
                              text: LocaleKeys.PleaseCode.tr(),
                              color: AppColors.greyText,
                              fontSize: AppFonts.t3,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.center),
                          SizedBox(height: height(context) * 0.07),
                          Directionality(
                              textDirection: TextDirection.ltr,
                              child: PinCodeTextField(
                                  appContext: context,
                                  controller: cubit.pinCtrl,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  pastedTextStyle: const TextStyle(
                                    color: AppColors.textColor),
                                  textStyle:
                                  const TextStyle(color: AppColors.textColor),
                                  length: 4,
                                  obscureText: false,
                                  obscuringCharacter: '-',
                                  animationType: AnimationType.fade,
                                  pinTheme: PinTheme(
                                      borderRadius: BorderRadius.circular(5),
                                      shape:PinCodeFieldShape.box,
                                      fieldHeight: height(context) * 0.09,
                                      fieldWidth: width(context) * 0.19,
                                      inactiveColor: AppColors.greyTextField,
                                      selectedFillColor: AppColors.whiteColor,
                                      activeColor: AppColors.textColor,
                                      activeFillColor: AppColors.whiteColor,
                                      inactiveFillColor: AppColors.whiteColor,
                                      selectedColor: AppColors.textColor),
                                  cursorColor: AppColors.textColor,
                                  animationDuration:
                                  const Duration(milliseconds: 300),
                                  enableActiveFill: true,
                                  keyboardType: TextInputType.number,
                                  animationCurve: Curves.bounceIn,
                                  onCompleted: (val)async{
                                   await cubit.activeAcc(context: context, phone: widget.phone);
                                  },
                                  onChanged: (value) {
                                    debugPrint(value);
                                  })),
                          currentSeconds >= timerMaxSeconds ? const SizedBox.shrink():SizedBox(height: height(context) * 0.03),
                          currentSeconds >= timerMaxSeconds ? const SizedBox.shrink():Directionality(
                              textDirection:TextDirection.ltr,
                              child: CustomText(text: timerText,color: AppColors.orangeColor,fontSize: AppFonts.t2)),
                          currentSeconds >= timerMaxSeconds ? SizedBox(height: height(context) * 0.03):SizedBox(height: height(context) * 0.05),
                          currentSeconds >= timerMaxSeconds ? CustomButton(
                              text: LocaleKeys.ResendCode.tr(),
                              onPressed: ()async{
                                await cubit.resendCode(context: context, phone: widget.phone);
                                startTimeout();
                              },
                              isOrange: false):const SizedBox.shrink(),
                          SizedBox(height: height(context)*0.02)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
