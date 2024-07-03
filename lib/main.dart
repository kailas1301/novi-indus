import 'package:flutter/material.dart';
import 'package:novi_indus/feautures/auth/presentation/log_in/login_view_model.dart';
import 'package:novi_indus/feautures/auth/presentation/splash_screen/splash_screen.dart';
import 'package:novi_indus/feautures/patient/presentation/home_screen/patient_vie_model.dart';
import 'package:novi_indus/feautures/register/presentation/branch_provider.dart';
import 'package:novi_indus/feautures/register/presentation/date_provider.dart';
import 'package:novi_indus/feautures/register/presentation/location_provider.dart';
import 'package:novi_indus/feautures/register/presentation/payment_provider.dart';
import 'package:novi_indus/feautures/register/presentation/time_provider.dart';
import 'package:provider/provider.dart';

late double screenWidth;
late double screenHeight;
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => PatientProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => BranchProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => DateProvider()),
        ChangeNotifierProvider(create: (_) => TimeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
