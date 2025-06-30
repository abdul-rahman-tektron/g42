import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smartcards/core/base/base_change_notifier.dart';
import 'package:smartcards/core/model/login/login_request.dart';
import 'package:smartcards/core/model/login/login_response.dart';
import 'package:smartcards/core/remote/service/auth_repository.dart';
import 'package:smartcards/utils/app_routes.dart';
import 'package:smartcards/utils/secure_storage.dart';
import 'package:smartcards/utils/toast_helper.dart';

class LoginNotifier extends BaseChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void loginFunctionality(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      runWithLoadingVoid(()=>  apiLogin(context));
    }
  }

  Future<void> apiLogin(BuildContext context) async {
    try {
      await AuthRepository().apiUserLogin(
          LoginRequest(userName: emailController.text, password: passwordController.text), context).then((
          value,) async {
        final result = value as LoginResult;
        await SecureStorageHelper.setToken(result.accessToken ?? "");

        Navigator.pushNamed(context, AppRoutes.bottomBar);
      });
    } catch (e, stackTrace) {
      debugPrint("Error in apiLogin: $e");
      debugPrintStack(stackTrace: stackTrace);
      ToastHelper.showError("Failed to load captcha. Please check your connection.");
    }
  }
}