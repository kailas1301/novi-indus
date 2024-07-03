import 'package:flutter/material.dart';

class DateProvider with ChangeNotifier {
  DateTime? _selectedDate;

  DateTime? getSelectedDate() {
    return _selectedDate;
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}
