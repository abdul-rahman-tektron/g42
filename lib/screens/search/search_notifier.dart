import 'dart:async';  // ⬅ Import needed for Timer
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smartcards/core/base/base_change_notifier.dart';
import 'package:smartcards/core/model/employee/employee_response.dart';
import 'package:smartcards/core/remote/service/auth_repository.dart';

class SearchNotifier extends BaseChangeNotifier {
  String _searchQuery = "";
  final List<EmployeeResult> _allEmployees = [];
  final TextEditingController searchController = TextEditingController();

  Timer? _debounce;

  SearchNotifier(BuildContext context) {
    runWithLoadingVoid(() => apiGetAllEmployee(context));
  }

  void setSearchQuery(String value) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      _searchQuery = value.toLowerCase().trim();
      notifyListeners();
    });
  }

  Future<void> apiGetAllEmployee(BuildContext context) async {
    try {
      final response = await AuthRepository().apiGetAllEmployee(context);
      _allEmployees.clear();
      _allEmployees.addAll(response as List<EmployeeResult>);
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching employees: $e');
    }
  }

  List<EmployeeResult> get filteredEmployees {
    if (_searchQuery.isEmpty) return _allEmployees;

    return _allEmployees.where((emp) {
      final name = (emp.fullName ?? "").toLowerCase();
      final dept = (emp.sBusinessUnitEn ?? "").toLowerCase();
      return name.contains(_searchQuery) || dept.contains(_searchQuery);
    }).toList();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }
}
