import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:game/Utils/AppColors.dart';



customSnackBar({required String title}) {
  return Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.primaryColor,
      textColor: AppColors.whiteColor,
      fontSize: 16.0);
}

customLoading({Color? color}) {
  return Center(
      child: CircularProgressIndicator(
        color: color ?? AppColors.primaryColor ,
      ));
}