class LoginRequest {
  final String userName;
  final String password;

  LoginRequest({required this.userName, required this.password});

  Map<String, dynamic> toJson() => {
    'username': userName,
    'password': password,
  };
}