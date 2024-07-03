import 'package:flutter/material.dart';

class LocationProvider with ChangeNotifier {
  final List<String> _districts = [
    'Thiruvananthapuram',
    'Kollam',
    'Pathanamthitta',
    'Alappuzha',
    'Kottayam',
    'Idukki',
    'Ernakulam',
    'Thrissur',
    'Palakkad',
    'Malappuram',
    'Kozhikode',
    'Wayanad',
    'Kannur',
    'Kasargod',
  ];

  List<String> getDistricts() => _districts;

  String? _selectedDistrict;

  void selectDistrict(String? district) {
    _selectedDistrict = district;
    notifyListeners();
  }

  String? getSelectedDistrict() {
    return _selectedDistrict;
  }
}
