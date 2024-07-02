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
  });

  final void Function() onPressed;
  final String buttonText;
  final double width; // Width of the button
  final double textSize; // Text size of the button text
  final Color textColor; // Text color of the button text

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // Set the width of the button
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kGreenColour,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        ),
        child: CustomText(
          fontWeight: FontWeight.w700,
          text: buttonText,
          color: textColor,
          size: textSize,
        ),
      ),
    );
  }
}
