import 'package:flutter/material.dart';
import 'package:game/AppModule/Auth/authController.dart';
import 'package:game/AppModule/Auth/loginScreen/LoginScreen.dart';
import 'package:game/Utils/AppColors.dart';
import 'package:game/Utils/AppImages.dart';
import 'package:game/Utils/AppText.dart';
import 'package:game/Utils/custom_toast.dart';
import 'package:game/Utils/widgets/AppButton.dart';
import 'package:game/Utils/widgets/PrimaryAppBar.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:game/leadScreen/View/lead.dart';

class SignUpScreen extends StatefulWidget {

  SignUpScreen({super.key,

  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthController authController = Get.put(AuthController());

  bool checkBoxValue1 = false;
  bool checkBoxValue2 = false;

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
            colors: [AppColors.primaryColor, AppColors.secondaryColor],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: primaryAppBar(
                title: 'ACCU-CHEK Solo',
                image: AppImages.rocheLogo,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    // Removed Expanded here
                    children: [
                      SizedBox(height: Get.height * 0.15),
                      buildTextField(authController.nameController, 'Name'),
                      const SizedBox(height: 20),
                      buildTextField(authController.emailController, 'Email'),
                      const SizedBox(height: 20),
                      buildTextField(authController.phoneController, 'Number'),
                      buildTextField(
                          authController.passwordController, 'Password'),
                      const SizedBox(height: 20),
                      buildTextField(authController.confirmPassController,
                          'Confirm Password'),
                      const SizedBox(height: 20),
                      buildCheckBoxRow(checkBoxValue1, "Checkbox 1"),
                      buildCheckBoxRow(checkBoxValue2, "Checkbox 2"),
                      const SizedBox(height: 20),
                     Obx(() =>

                     authController.isLoading.isTrue?customLoading(color: AppColors.yellowColor):
                      AppButton(
                        buttonWidth: Get.width * 0.7,
                        buttonHeight: Get.height * 0.07,
                        buttonText: 'Continue',
                        buttonColor: AppColors.yellowColor,
                        textColor: AppColors.primaryColor,
                        onTap: () {
                          // Navigator.of(context).push(
                          //     MaterialPageRoute(builder: (context) => GameScreen()));
                          authController.sigUpValidation();
                        },
                        buttonRadius: BorderRadius.circular(5),
                      ),),
                      const SizedBox(height: 45),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          appText(text: 'Already have an account',textColor: AppColors.whiteColor),
                          GestureDetector(
                            onTap: () {
                              Get.to(LoginScreen());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.arrow_circle_right,
                                size: 40,
                                color: AppColors.yellowColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildTextField(TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: AppColors.greyColor),
        textAlign: TextAlign.center,

        decoration: InputDecoration(
          labelStyle: TextStyle(color: AppColors.greyColor),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }

  Row buildCheckBoxRow(bool checkBoxValue, String label) {
    return Row(
      children: [
        Checkbox(
          value: checkBoxValue,
          activeColor: AppColors.yellowColor,
          onChanged: (bool? value) {
            setState(() {
              if (label == "Checkbox 1") {
                checkBoxValue1 = value!;
              } else if (label == "Checkbox 2") {
                checkBoxValue2 = value!;
              }
            });
          },
        ),
        appText(text: label, textColor: AppColors.whiteColor),
      ],
    );
  }
}
