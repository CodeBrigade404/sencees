import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  final String username;
  final String? accessToken;

  Login({
    required this.username,
    required this.accessToken,
  });

  Login copyWith({
    String? username,
    String? accessToken,
  }) =>
      Login(
        username: username ?? this.username,
        accessToken: accessToken ?? this.accessToken,
      );

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        username: json["username"] ?? '',
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "access_token": accessToken,
      };
}
