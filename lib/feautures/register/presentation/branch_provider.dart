import 'package:flutter/material.dart';
import 'package:novi_indus/feautures/register/data/api/branch_services.dart';
import 'package:novi_indus/feautures/register/data/model/branch_model.dart';

class BranchProvider with ChangeNotifier {
  List<Branch> _branches = [];
  Branch? _selectedBranch;
  bool _isLoading = false;
  String? _errorMessage;

  // Constructor
  BranchProvider() {
    fetchBranches(); // Fetch branches when the provider is created
  }

  // Method to select a branch
  void selectBranch(Branch? branch) {
    _selectedBranch = branch;
    notifyListeners();
  }

  // Method to fetch branches from the service
  Future<void> fetchBranches() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final branchService = BranchService();
      _branches = await branchService.fetchBranches();
      // Set initial selectedBranch to the first branch if available
      if (_branches.isNotEmpty) {
        _selectedBranch = _branches.first;
      } else {
        _selectedBranch = null; // Or set a default branch if appropriate
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Method to access branches
  List<Branch> getBranches() => _branches;

  // Method to access selectedBranch
  Branch? getSelectedBranch() => _selectedBranch;

  // Method to check if loading
  bool getIsLoading() => _isLoading;

  // Method to access error message
  String? getErrorMessage() => _errorMessage;
}
