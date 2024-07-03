import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:novi_indus/feautures/auth/data/api/auth_service.dart';
import 'package:novi_indus/feautures/register/data/model/treatment_model.dart';

class TreatmentServices {
  final String _baseUrl = 'https://flutter-amr.noviindus.in/api';

  Future<List<Treatment>> fetchTreatments() async {
    String token = await AuthService().retrieveToken();
    final url = Uri.parse('$_baseUrl/TreatmentList');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> treatmentsJson = data['treatments'];
      return treatmentsJson.map((json) => Treatment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load treatments');
    }
  }
}
