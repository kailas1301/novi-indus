import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:novi_indus/feautures/auth/data/api/auth_service.dart';
import 'package:novi_indus/feautures/register/data/model/branch_model.dart';

class BranchService {
  final String url = 'https://flutter-amr.noviindus.in/api/BranchList';

  Future<List<Branch>> fetchBranches() async {
    final token = await AuthService().retrieveToken();
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final branches = data["branches"];
      List<Branch> branchList = [];
      for (var branch in branches) {
        final value = Branch.fromJson(branch);
        branchList.add(value);
      }
      return branchList;
    } else {
      throw Exception('Failed to load branches');
    }
  }
}
