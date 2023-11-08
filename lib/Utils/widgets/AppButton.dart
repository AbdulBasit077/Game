import 'package:flutter/material.dart';
import '../AppBorderRadius.dart';
import '../AppText.dart';

class AppButton extends StatelessWidget {
  final String buttonText;
  final double buttonWidth;
  final double buttonHeight;
  final VoidCallback? onTap;
  final Color buttonColor;
  final Color textColor;
  final BorderRadius buttonRadius;

  AppButton({
    Key? key,
    required this.buttonText,
    this.buttonWidth = 250,
    this.buttonHeight = 50,
    required this.buttonColor,
    this.textColor = Colors.white,
    required this.onTap,
    required this.buttonRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: buttonRadius,
        ),
        child: Center(
          child: appText(text: buttonText, textColor: textColor, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
