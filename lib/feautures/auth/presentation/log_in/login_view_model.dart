import 'package:flutter/material.dart';
import 'package:novi_indus/feautures/auth/data/api/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool isAuthenticated = false;

  Future<void> login(String username, String password) async {
    try {
      final status = await _authService.login(username, password);
      isAuthenticated = status;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> logout() async {
    await _authService.removeToken();
    isAuthenticated = false;
    notifyListeners();
  }

  bool isAuthenticationDone() {
    return isAuthenticated;
  }
}
