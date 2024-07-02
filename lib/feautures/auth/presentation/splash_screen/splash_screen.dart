import 'package:flutter/material.dart';
import 'package:novi_indus/feautures/auth/data/api/auth_service.dart';
import 'package:novi_indus/feautures/patient/presentation/home_screen/home_screen.dart';
import 'package:novi_indus/feautures/auth/presentation/log_in/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Check authentication status
    AuthService authService = AuthService();
    authService.retrieveToken().then((token) {
      // Delayed navigation after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (token.isNotEmpty) {
          // User is logged in, navigate to HomeScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          // No token found, navigate to LoginScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      });
    });

    return Scaffold(
      body: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: Image.asset('assets/images/splash.png'),
        ),
      ),
    );
  }
}
