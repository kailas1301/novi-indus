import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:novi_indus/core/constants/constants.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.errorText,
    this.obscureText,
    this.validatorFunction,
    this.keyboardType,
    this.prefixIcon,
    this.hintColor,
    this.textfieldColor,
  });

  final TextEditingController controller;
  final String hintText;
  final String? errorText;
  final bool? obscureText;
  final Function(String?)? validatorFunction;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final Color? hintColor;
  final Color? textfieldColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: textfieldColor ?? const Color.fromARGB(255, 246, 242, 242),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: kGreyColour),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 237, 237, 237).withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(2, 2), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: kDarkGreyColour,
        ),
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        controller: controller,
        decoration: InputDecoration(
          labelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.normal,
            color: kDarkGreyColour,
            fontSize: 13,
          ),
          hintFadeDuration: const Duration(seconds: 1),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintStyle: GoogleFonts.openSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: hintColor ?? kDarkGreyColour,
          ),
          floatingLabelStyle: GoogleFonts.openSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: kDarkGreyColour),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          fillColor: kGreyColour,
          hintText: hintText,
          errorText: errorText, // Custom error text
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: kGreyColour,
                )
              : null,
        ),
        validator: validatorFunction != null
            ? (value) => validatorFunction!(value)
            : (value) {
                if (value == null || value.isEmpty) {
                  return errorText;
                }
                return null; // Valid
              },
      ),
    );
  }
}
