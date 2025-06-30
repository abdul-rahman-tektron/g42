import 'package:flutter/material.dart';
import 'package:smartcards/core/base/base_change_notifier.dart';
import 'package:smartcards/core/model/employee/employee_response.dart';
import 'package:smartcards/core/remote/service/auth_repository.dart';

class ScanNotifier extends BaseChangeNotifier {
  String? _scannedValue;
  String? _qrCodeData;
  EmployeeResult? matchedEmployee;

  void clear() {
    _scannedValue = null;
    _qrCodeData = null;
    matchedEmployee = null;
    notifyListeners();
  }

  Future<void> processScan(BuildContext context, String qrValue) async {
    final trimmed = qrValue.trim();
    if (trimmed.isEmpty) return;

    scannedValue = trimmed;
    qrCodeData = extractQrData(trimmed);

    await apiGetEmployee(context);
  }

  Future<void> apiGetEmployee(BuildContext context) async {
    try {
      final response = await AuthRepository().apiGetEmployee("048o2bLHbLwbUAy4YmoRCQ==", context);

      matchedEmployee = response as EmployeeResult?;

      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching Employee details: $e');
      // Optionally show toast or error handling here
    }
  }

  String? extractQrData(String qrValue) {
    final clean = qrValue.startsWith('qrc:') ? qrValue.replaceFirst('qrc:', '') : qrValue;
    final parts = clean.split(';');
    if (parts.length >= 2 && parts[1].isNotEmpty) {
      return parts[1]; // e.g. "V34" or "V43"
    }
    return null;
  }

  String? get scannedValue => _scannedValue;

  set scannedValue(String? value) {
    if (_scannedValue == value) return;
    _scannedValue = value;
    notifyListeners();
  }

  String? get qrCodeData => _qrCodeData;

  set qrCodeData(String? value) {
    if (_qrCodeData == value) return;
    _qrCodeData = value;
    notifyListeners();
  }
}
