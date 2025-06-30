import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResult? result;
  int? statusCode;
  String? message;
  String? status;

  LoginResponse({
    this.result,
    this.statusCode,
    this.message,
    this.status,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    result: json["result"] == null ? null : LoginResult.fromJson(json["result"]),
    statusCode: json["statusCode"],
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": result?.toJson(),
    "statusCode": statusCode,
    "message": message,
    "status": status,
  };
}

class LoginResult {
  String? accessToken;
  String? refreshToken;

  LoginResult({
    this.accessToken,
    this.refreshToken,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult(
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
  };
}