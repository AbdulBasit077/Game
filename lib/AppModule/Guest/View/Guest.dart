import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:game/AppModule/Auth/authController.dart';
import 'package:game/AppModule/Auth/signUpScreen/View/Sign.dart';
import 'package:game/AppModule/HomeScreen/HomeScreen.dart';
import 'package:game/Utils/AppColors.dart';
import 'package:game/Utils/AppImages.dart';
import 'package:game/Utils/AppText.dart';
import 'package:game/Utils/custom_toast.dart';
import 'package:game/Utils/widgets/AppButton.dart';
import 'package:get/get.dart';
import '../../../Utils/widgets/PrimaryAppBar.dart';
class GuestScreen extends StatefulWidget {
  @override
  _GuestScreenState createState() => _GuestScreenState();
}
class _GuestScreenState extends State<GuestScreen> {
  Country? _selectedCountry;
  String? _selectedLanguage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primaryColor, AppColors.secondaryColor],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 35),
                primaryAppBar(
                    title: 'ACCU-CHEK Solo', image: AppImages.rocheLogo),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppButton(
                        buttonWidth: Get.width * 0.7,
                        buttonHeight: Get.height * 0.07,
                        buttonText: _selectedCountry == null
                            ? 'Select Country'
                            : _selectedCountry!.name,
                        buttonColor: AppColors.yellowColor,
                        textColor: AppColors.primaryColor,
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            onSelect: (Country country) {
                              setState(() {
                                _selectedCountry = country;
                                Get.put(AuthController()).setCountry=country.name;


                              });
                            },
                          );
                        },
                        buttonRadius: BorderRadius.circular(5),
                      ),
                      const SizedBox(height: 20),
                      AppButton(
                        buttonWidth: Get.width * 0.7,
                        buttonHeight: Get.height * 0.07,
                        buttonText: _selectedLanguage == null
                            ? 'Select Language'
                            : _selectedLanguage!,
                        buttonColor: AppColors.yellowColor,
                        textColor: AppColors.primaryColor,
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <String>['English', 'Urdu']
                                        .map((String value) {
                                      return ListTile(
                                        title: Text(value),
                                        onTap: () {
                                          setState(() {
                                            _selectedLanguage = value;
                                          });
                                          Navigator.pop(context);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                );
                              });
                        },
                        buttonRadius: BorderRadius.circular(5),
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          Get.to(()=>HomeScreen());
                        },
                        child: appText(
                            text: 'Continue as Guest',
                            textColor: AppColors.yellowColor,
                            textDecoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(_selectedCountry==null){
                          customSnackBar(title: 'Please Select your country');
                        }else{
                          Get.to(()=>SignUpScreen());
                        }

                      },
                      child: Icon(Icons.arrow_circle_right,
                          size: 40, color: AppColors.yellowColor),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
