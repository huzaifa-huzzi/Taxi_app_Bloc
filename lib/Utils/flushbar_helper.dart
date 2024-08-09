import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showErrorFlushbar(BuildContext context, String message) {
  Flushbar(
    title: 'Error',
    message: message,
    duration: Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.BOTTOM,
    backgroundColor: Colors.red,
    borderRadius:BorderRadius.circular(7),
    padding: EdgeInsets.all(15),
    margin:EdgeInsets.all(15) ,
    icon: Icon(
      Icons.error,
      color: Colors.white,
    ),
  )..show(context);
}

void showSuccessfullyFlushbar(BuildContext context, String message) {
  Flushbar(
    title: 'Successfull',
    message: message,
    duration: Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.BOTTOM,
    backgroundColor: Colors.green,
    borderRadius:BorderRadius.circular(7),
    padding: EdgeInsets.all(15),
    margin:EdgeInsets.all(15) ,
    icon: Icon(
      Icons.check_circle,
      color: Colors.white,
    ),
  )..show(context);
}
