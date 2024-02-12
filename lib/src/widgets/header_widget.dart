import 'package:flutter/cupertino.dart';
import 'package:opticalapp/src/utilities/utilites.dart';
import 'package:flutter/material.dart';

Widget headerWid(double width, double height, String title, Icon icon) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey[200], width: 1),
        borderRadius: BorderRadius.circular(9)),
    width: width,
    height: height,
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 16, fontFamily: 'Semibold', color: secondaryColor),
        )
      ],
    ),
  );
}
