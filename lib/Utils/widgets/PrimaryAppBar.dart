import 'package:flutter/material.dart';
import 'package:game/Utils/AppColors.dart';
import 'package:game/Utils/AppDimensions.dart';
import 'package:game/Utils/AppImages.dart';
import 'package:game/Utils/AppText.dart';

primaryAppBar({
  String? title,
  String? image,
}) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        appText(
          text: title!,
          textColor: AppColors.whiteColor,
          size: AppDimensions.fontSize20,
        ),
        Image.asset(image!,scale: 2,),
      ],
    ),
  );
}