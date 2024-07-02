import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:novi_indus/feautures/auth/data/api/auth_service.dart';
import 'package:novi_indus/feautures/patient/data/models/patient_model.dart';

class PatientService {
  static const String baseUrl = "https://flutter-amr.noviindus.in/api";

  Future<List<Patient>> fetchPatients() async {
    final token = await AuthService().retrieveToken();

    final response = await http.get(
      Uri.parse('$baseUrl/PatientList'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print("Fetch patients function is success");
      final data = jsonDecode(response.body);
      List<Patient> patients = [];

      for (var patientJson in data['patient']) {
        try {
          final patient = Patient.fromJson(patientJson);
          patients.add(patient);
          print("Patient ID: ${patient.id}");
          print("Name: ${patient.name}");
          print("Date and Time: ${patient.dateTime ?? 'No Date/Time'}");
          print(
              "Treatment Name: ${patient.treatmentName ?? 'No Treatment Name'}");
          print("-----------------------------");
        } catch (e) {
          print("Failed to parse patient data: $e");
        }
      }

      return patients;
    } else {
      print(
          "Fetch patients function encountered an error: ${response.statusCode}");
      throw Exception('Failed to load patients');
    }
  }
}
