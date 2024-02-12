import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

toast(String message, Color bgColor, Color txColor, double fontSize) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: bgColor,
      textColor: txColor,
      fontSize: fontSize);
}
