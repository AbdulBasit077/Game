import 'package:flutter/material.dart';
import 'package:game/Utils/AppColors.dart';
import 'package:game/Utils/AppImages.dart';
import 'package:game/Utils/widgets/AppButton.dart';
import '../../../Utils/widgets/PrimaryAppBar.dart';
import '../../runnerScreen/View/run.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primaryColor, AppColors.secondaryColor],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Column(
                children: [
                  SizedBox(height: statusBarHeight + screenHeight * 0.02),
                  primaryAppBar(title: 'ACCU-CHEK Solo', image: AppImages.image1),
                  Flexible(child: SizedBox(), flex: 1),

                  SizedBox(height: 80),

                  Text(
                    'JUMP TO ESCAPE',
                    style: TextStyle(
                      color: AppColors.yellowColor,
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'THE INSULIN PENS',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Image.asset(
                    "assets/png/ruche1-removebg-preview.png",
                    width: screenWidth * 0.6,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  AppButton(
                    buttonWidth: screenWidth * 0.7,
                    buttonHeight: screenHeight * 0.07,
                    buttonText: 'Play Now',
                    buttonColor: AppColors.yellowColor,
                    textColor: AppColors.primaryColor,
                    onTap: () {
                      // Here you should navigate to the GamePage, but first, ensure that the GamePage class is defined in your project.
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => TRexGameScreen()));

                    },

                    buttonRadius: BorderRadius.circular(5),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  AppButton(
                    buttonWidth: screenWidth * 0.7,
                    buttonHeight: screenHeight * 0.07,
                    buttonText: 'Leaderboard',
                    buttonColor: AppColors.yellowColor,
                    textColor: AppColors.primaryColor,
                    onTap: () {
                      // Navigate to leaderboard screen
                    },
                    buttonRadius: BorderRadius.circular(5),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: statusBarHeight + 10.0,
            right: 10.0,
            child: PopupMenuButton<String>(
              icon: Icon(Icons.settings, color: Colors.white),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Edit Profile',
                  child: Text('Edit Profile'),
                ),
                const PopupMenuItem<String>(
                  value: 'Logout',
                  child: Text('Logout'),
                ),
              ],
              onSelected: (String value) {
                switch (value) {
                  case 'Edit Profile':
                  // Add your edit profile navigation or functionality here
                    break;
                  case 'Logout':
                  // Add your logout navigation or functionality here
                    break;
                  default:
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
