import 'package:flutter/material.dart';

class TimeProvider with ChangeNotifier {
  int? _selectedHour;
  int? _selectedMinute;

  int? getSelectedHour() {
    return _selectedHour;
  }

  int? getSelectedMinute() {
    return _selectedMinute;
  }

  void selectHour(int hour) {
    _selectedHour = hour;
    notifyListeners();
  }

  void selectMinute(int minute) {
    _selectedMinute = minute;
    notifyListeners();
  }
}
