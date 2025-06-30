import 'package:flutter/widgets.dart';
import 'package:smartcards/res/app_language_text.dart';
import 'package:smartcards/utils/regex.dart';

class CommonValidation {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
    final emailRegex = RegExp(LocalInputRegex.email);
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email address.';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    return null;
  }

  String? validateConfirmPassword(String? oldValue, String? newValue) {
    if (newValue == null || newValue.isEmpty) {
      return 'Confirm password is required.';
    }
    if (oldValue != newValue) {
      return 'Passwords do not match.';
    }
    return null;
  }

  String? commonValidator(String? value) =>
      _requiredFieldValidator(value, 'Please enter data.');

  // Helper method for common required field validations
  String? _requiredFieldValidator(String? value, String message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }
}


