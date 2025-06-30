import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:smartcards/core/model/employee/employee_response.dart';
import 'package:smartcards/core/model/error/error_response.dart';
import 'package:smartcards/core/model/login/login_request.dart';
import 'package:smartcards/core/model/login/login_response.dart';
import 'package:smartcards/core/remote/network/app_url.dart';
import 'package:smartcards/core/remote/network/base_repository.dart';
import 'package:smartcards/core/remote/network/method.dart';
import 'package:smartcards/utils/encrypt.dart';
import 'package:smartcards/utils/secure_storage.dart';

class AuthRepository extends BaseRepository with CommonFunctions{
  AuthRepository._internal();

  static final AuthRepository _singleInstance = AuthRepository._internal();

  factory AuthRepository() => _singleInstance;

  ErrorResponse _errorResponseMessage = ErrorResponse();

  ErrorResponse get errorResponseMessage => _errorResponseMessage;

  set errorResponseMessage(ErrorResponse value) {
    if (value == _errorResponseMessage) return;
    _errorResponseMessage = value;
    notifyListeners();
  }

  //api: Logins
  Future<Object?> apiUserLogin(LoginRequest requestParams, BuildContext context) async {

    Response? response = await networkProvider.call(
      method: Method.POST,
      // pathUrl: AppUrl.pathLogin,
      pathUrl: AppUrl.pathLogin,
      body: jsonEncode(requestParams.toJson()),
      headers: headerContentTypeAndAccept,
    );

    if (response?.statusCode == HttpStatus.ok) {
      LoginResponse loginResponse = loginResponseFromJson(jsonEncode(response?.data ?? ""));
      return loginResponse.result;
    } else {
      ErrorResponse errorString = ErrorResponse.fromJson(response?.data ?? "");
      return errorString.title;
    }
    return null;
  }

  //api: Get Employee
  Future<Object?> apiGetEmployee(String id, BuildContext context) async {

    final token = await SecureStorageHelper.getToken();

    Response? response = await networkProvider.call(
      method: Method.GET,
      pathUrl: AppUrl.pathGetEmployee,
      queryParam: id,
      headers: buildDefaultHeaderWithToken(token ?? ""),
    );

    if (response?.statusCode == HttpStatus.ok) {
      EmployeeResponse employeeResponse = employeeResponseFromJson(jsonEncode(response?.data ?? ""));

      return employeeResponse.result?[0] ?? [];

    } else {
      ErrorResponse errorString = ErrorResponse.fromJson(response?.data ?? "");
      return errorString.title;
    }
    return null;
  }


  //api: Get All Employee
  Future<Object?> apiGetAllEmployee(BuildContext context) async {

    final token = await SecureStorageHelper.getToken();

    Response? response = await networkProvider.call(
      method: Method.GET,
      pathUrl: AppUrl.pathGetAllEmployee,
      headers: buildDefaultHeaderWithToken(token ?? ""),
    );

    if (response?.statusCode == HttpStatus.ok) {
      EmployeeResponse employeeResponse = employeeResponseFromJson(jsonEncode(response?.data ?? ""));

      return employeeResponse.result;

    } else {
      ErrorResponse errorString = ErrorResponse.fromJson(response?.data ?? "");
      return errorString.title;
    }
    return null;
  }
}
