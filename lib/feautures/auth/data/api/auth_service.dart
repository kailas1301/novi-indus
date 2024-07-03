import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = "https://flutter-amr.noviindus.in/api";

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Login'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      print("sucessfull login: ${response.statusCode}");
      final data = jsonDecode(response.body);
      final token = data['token'];
      final executive = data["user_details"]["name"];
      saveToken(token, executive);
      print(executive);
      return data["status"];
    } else {
      print("Failed to login: ${response.statusCode}");
      throw Exception('Failed to login');
    }
  }

  Future<void> saveToken(String token, String executive) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setString('executive', executive);
  }

  Future<String> retrieveToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    return token ?? '';
  }

  Future<String> retrieveExecutive() async {
    final prefs = await SharedPreferences.getInstance();
    String? executive = prefs.getString('executive');
    return executive ?? '';
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}
