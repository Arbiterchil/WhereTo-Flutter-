import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';


class DialogOrder{
  getDialog(BuildContext context, String message, String title, IconData icon, Color color){
    Flushbar(
      title: title,
      messageText: Text(
        message,
        style: TextStyle(fontSize: 17.0, color: Colors.white),
      ),
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.easeInOutExpo,
      progressIndicatorBackgroundColor: Color(0xFFFF3345),
      shouldIconPulse: true,
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.BOTTOM,
      isDismissible: true,
      icon: Icon(
        icon ,
        size: 30.0,
        color: color
      ),
      duration: Duration(seconds: 8),
    )..show(context);
  }
}