import 'package:flutter/material.dart';
import 'package:novi_indus/core/constants/constants.dart';
import 'package:novi_indus/core/widgets/custom_text.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.width,
    required this.textSize,
    required this.textColor,
    this.fontWeight,
    this.buttonColor,
  });

  final void Function() onPressed;
  final String buttonText;
  final double width;
  final double textSize;
  final Color textColor;
  final Color? buttonColor;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? kGreenColour,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        ),
        child: CustomText(
          fontWeight: fontWeight ?? FontWeight.w700,
          text: buttonText,
          color: textColor,
          size: textSize,
        ),
      ),
    );
  }
}
