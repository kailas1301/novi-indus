import 'package:flutter/material.dart';
import 'package:novi_indus/feautures/register/data/api/branch_services.dart';
import 'package:novi_indus/feautures/register/data/model/branch_model.dart';

class BranchProvider with ChangeNotifier {
  List<Branch> _branches = [];
  Branch? _selectedBranch;
  bool _isLoading = false;
  String? _errorMessage;

  BranchProvider() {
    fetchBranches();
  }

  void selectBranch(Branch? branch) {
    _selectedBranch = branch;
    notifyListeners();
  }

  Future<void> fetchBranches() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final branchService = BranchService();
      _branches = await branchService.fetchBranches();
      if (_branches.isNotEmpty) {
        _selectedBranch = null; // Ensure no branch is selected initially
      } else {
        _selectedBranch = null;
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Branch> getBranches() => _branches;

  Branch? getSelectedBranch() => _selectedBranch;

  bool getIsLoading() => _isLoading;

  String? getErrorMessage() => _errorMessage;
}
