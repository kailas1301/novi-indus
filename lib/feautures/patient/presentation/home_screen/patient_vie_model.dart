import 'package:flutter/material.dart';
import 'package:novi_indus/feautures/patient/data/api/patient_services.dart';
import 'package:novi_indus/feautures/patient/data/models/patient_model.dart';

class PatientProvider with ChangeNotifier {
  List<Patient> patients = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchPatients() async {
    isLoading = true;
    notifyListeners();

    try {
      print("fetch patients function is called");
      patients = await PatientService().fetchPatients();
      errorMessage = null;
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
