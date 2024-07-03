import 'package:flutter/material.dart';

class DateProvider with ChangeNotifier {
  DateTime? _selectedDate;

  // Get the selected date
  DateTime? getSelectedDate() {
    return _selectedDate;
  }

  // Select a new date
  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}
