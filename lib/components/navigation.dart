import 'package:flutter/material.dart';

/// Navigator Push

void navigateTo({required BuildContext context, required Widget widget}) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
/// Navigator Finish
void navigateAndFinish({required BuildContext context,required Widget widget}) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (Route<dynamic> route) => false);


/// Navigator Pop

 navigatorPop({required BuildContext context})=> Navigator.of(context).pop();

/// Navigator And Replace
navigateAndReplace({required BuildContext context,required Widget widget}) => Navigator.pushReplacement(

    context,
    MaterialPageRoute(builder: (context) => widget)).then((value) {});