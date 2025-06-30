import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:smartcards/core/base/base_change_notifier.dart';
import 'package:smartcards/core/model/employee/employee_response.dart';
import 'package:smartcards/core/remote/service/auth_repository.dart';

class DashboardNotifier extends BaseChangeNotifier {

  final List<EmployeeResult> allEmployees = [];
  List<DashboardCardData>? cardData;

  DashboardNotifier(BuildContext context) {
    cardData = [
      DashboardCardData(
        icon: LucideIcons.calendar,
        titleKey: "Today",
        count: 21 ?? 0,
      ),
      DashboardCardData(
        icon: LucideIcons.calendarDays,
        titleKey: "Yesterday",
        count: 30 ?? 0,
      ),
      DashboardCardData(
        icon: LucideIcons.calendarCheck,
        titleKey: "This Month",
        count: 55 ?? 0,
      ),
      DashboardCardData(
        icon: LucideIcons.scanLine,
        titleKey: "Total",
        count: 109 ?? 0,
      ),
    ];
    runWithLoadingVoid(() => apiGetAllEmployee(context));
  }


  Future<void> apiGetAllEmployee(BuildContext context) async {
    try {
      final response = await AuthRepository().apiGetAllEmployee(context);
      allEmployees.clear();
      allEmployees.addAll(response as List<EmployeeResult>);
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching employees: $e');
    }
  }
}

class DashboardCardData {
  final IconData icon;
  final String titleKey;  // <-- store key, not translated string
  final int count;

  DashboardCardData({
    required this.icon,
    required this.titleKey,
    required this.count,
  });
}