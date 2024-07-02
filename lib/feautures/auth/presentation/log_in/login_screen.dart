import 'package:flutter/material.dart';
import 'package:novi_indus/core/constants/constants.dart';
import 'package:novi_indus/core/widgets/custom_text.dart';
import 'package:novi_indus/core/widgets/elevated_button.dart';
import 'package:novi_indus/core/widgets/text_form_field.dart';
import 'package:novi_indus/main.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: screenHeight * .25,
                width: screenWidth,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/login_frame.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              kSizedBoxH20,
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        fontWeight: FontWeight.w700,
                        text: "Login Or Register To Book",
                        color: kblackColour,
                        size: 24),
                    CustomText(
                        fontWeight: FontWeight.w700,
                        text: "Your Appointments",
                        color: kblackColour,
                        size: 24),
                  ],
                ),
              ),
              kSizedBoxH20,
              // textform fields
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                        text: "Email", color: kblackColour, size: 14),
                    kSizedBoxH10,
                    TextFormFieldWidget(
                      controller: emailController,
                      hintText: "Enter your Email",
                    ),
                    kSizedBoxH20,
                    const CustomText(
                        text: "Password", color: kblackColour, size: 14),
                    kSizedBoxH10,
                    TextFormFieldWidget(
                      controller: passwordController,
                      hintText: "Enter password",
                    ),
                  ],
                ),
              ),
              // login Button
              kSizedBoxH30,
              kSizedBoxH30,
              Center(
                child: ElevatedButtonWidget(
                    width: 380,
                    onPressed: () {},
                    buttonText: "Login",
                    textSize: 16,
                    textColor: kwhiteColour),
              ),
              const SizedBox(
                height: 80,
              ),
              // texts
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                      text:
                          "By creating or logging into an account you are agreeing",
                      color: kDarkGreyColour,
                      size: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                          text: "with our ", color: kDarkGreyColour, size: 14),
                      CustomText(
                          text: "Terms and Conitions ",
                          color: kBlueColour,
                          size: 14),
                      CustomText(
                          text: "and ", color: kDarkGreyColour, size: 14),
                      CustomText(
                          text: "Privacy Policy", color: kBlueColour, size: 14),
                    ],
                  ),
                ],
              ),
              kSizedBoxH30,
            ],
          ),
        ),
      ),
    );
  }
}
