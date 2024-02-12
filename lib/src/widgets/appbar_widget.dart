import 'package:flutter/material.dart';
import 'package:opticalapp/src/utilities/utilites.dart';
import 'package:flutter/cupertino.dart';

Widget appBarWid(BuildContext context) {
  return Row(
    children: [
      RichText(
          text: TextSpan(style: TextStyle(fontSize: 22), children: <TextSpan>[
        TextSpan(
            text: 'Tu',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
                fontFamily: 'Medium')),
        TextSpan(
            text: 'Vision',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: secondaryColor,
                fontFamily: 'Regular')),
      ])),
      SizedBox(
        width: 5,
      ),
      Icon(
        CupertinoIcons.eyeglasses,
        color: primaryColor,
      ),
    ],
  );
}
