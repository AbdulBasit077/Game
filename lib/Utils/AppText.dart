

import 'package:flutter/material.dart';
import 'package:game/Utils/AppDimensions.dart';

Widget appText({
  required String text,
  TextAlign textAlign=TextAlign.left,
  int maxLines=1,
  TextOverflow? textOverflow,
  TextStyle? style,
  String  fontFamily='Lato',
  double size=AppDimensions.fontSize16,
  FontWeight fontWeight=FontWeight.w400,
  FontStyle fontStyle =FontStyle.normal,
  Color textColor =Colors.black,
  TextDecoration textDecoration=TextDecoration.none,
}){
  return Text(text,
  textAlign: textAlign,
  maxLines:maxLines,
    overflow: textOverflow,

    style: style ??
    TextStyle(
      fontFamily: fontFamily,
      fontSize:size,
      fontWeight:fontWeight,
      fontStyle: fontStyle,
      color:textColor,
      decoration: textDecoration,

    ),
  );
}