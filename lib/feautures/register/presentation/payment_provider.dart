import 'package:flutter/material.dart';

enum PaymentOption { cash, card, upi }

class PaymentProvider with ChangeNotifier {
  PaymentOption _selectedOption = PaymentOption.cash;

  void selectOption(PaymentOption option) {
    _selectedOption = option;
    notifyListeners();
  }

  PaymentOption getSelectedOption() => _selectedOption;

  List<Map<String, dynamic>> getPaymentOptions() {
    return [
      {'label': 'Cash', 'value': PaymentOption.cash},
      {'label': 'Card', 'value': PaymentOption.card},
      {'label': 'UPI', 'value': PaymentOption.upi},
    ];
  }
}
