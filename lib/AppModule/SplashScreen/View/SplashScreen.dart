import 'package:flutter/material.dart';
import 'package:game/AppModule/Guest/View/Guest.dart';
import 'package:game/AppModule/HomeScreen/HomeScreen.dart';
import 'package:game/Utils/AppColors.dart';
import 'package:game/Utils/AppImages.dart';
import 'package:game/Utils/AppStringConstants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3),(){
      // Get.to(GuestScreen());
      checkLogin();
    });
  }
  checkLogin()async{
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getBool(AppConstant.login)==true){
      Get.offAll(()=>HomeScreen());
    }else{
      Get.to(() => GuestScreen());    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
         height: Get.height,
        decoration: BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.primaryColor,AppColors.secondaryColor],

        ),
        ),
        child: Center(
          child: Image.asset(AppImages.rocheLogo),


        ),
      ),


    );
  }
}

