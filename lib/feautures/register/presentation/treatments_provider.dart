import 'package:flutter/material.dart';
import 'package:novi_indus/feautures/register/data/api/treatment_services.dart';
import 'package:novi_indus/feautures/register/data/model/treatment_model.dart';

class TreatmentProvider with ChangeNotifier {
  List<Treatment> _treatments = [];
  final List<Map<String, dynamic>> _selectedTreatments = [];

  int _maleCount = 0;
  int _femaleCount = 0;

  final TreatmentServices _treatmentServices = TreatmentServices();

  Future<void> fetchTreatments() async {
    try {
      _treatments = await _treatmentServices.fetchTreatments();
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to load treatments');
    }
  }

  void selectTreatment(Treatment treatment) {
    if (_selectedTreatments.any((t) => t['id'] == treatment.id)) return;
    final treatmentData = {
      'name': treatment.name,
      'id': treatment.id,
      'price': treatment.price,
    };
    _selectedTreatments.add(treatmentData);
    notifyListeners();
  }

  void removeTreatment(Treatment treatment) {
    _selectedTreatments.removeWhere(
        (selectedTreatment) => selectedTreatment['id'] == treatment.id);
    notifyListeners();
  }

  void increaseMaleCount() {
    _maleCount++;
    notifyListeners();
  }

  void decreaseMaleCount() {
    if (_maleCount > 0) {
      _maleCount--;
      notifyListeners();
    }
  }

  void increaseFemaleCount() {
    _femaleCount++;
    notifyListeners();
  }

  void decreaseFemaleCount() {
    if (_femaleCount > 0) {
      _femaleCount--;
      notifyListeners();
    }
  }

  List<Treatment> getTreatments() => _treatments;

  List<Map<String, dynamic>> getSelectedTreatments() => _selectedTreatments;

  Treatment? getSelectedTreatment() {
    return _selectedTreatments.isNotEmpty
        ? _treatments.firstWhere(
            (treatment) => treatment.id == _selectedTreatments.last['id'])
        : null;
  }

  int getMaleCount() => _maleCount;

  int getFemaleCount() => _femaleCount;
}
