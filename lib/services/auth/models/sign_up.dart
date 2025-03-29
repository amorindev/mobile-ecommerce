// ! que demas modelos se puede y debe crear
// To parse this JSON data, do
//
//     final authCreateRequest = authCreateRequestFromJson(jsonString);

import 'dart:convert';

AuthCreateRequest authCreateRequestFromJson(String str) =>
    AuthCreateRequest.fromJson(json.decode(str));

String authCreateRequestToJson(AuthCreateRequest data) =>
    json.encode(data.toJson());

class AuthCreateRequest {
  String email;
  String password;
  UserCreateRequest user;

  AuthCreateRequest({
    required this.email,
    required this.password,
    required this.user,
  });

  factory AuthCreateRequest.fromJson(Map<String, dynamic> json) =>
      AuthCreateRequest(
        email: json["email"],
        password: json["password"],
        user: UserCreateRequest.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "user": user.toJson(),
      };
}

class UserCreateRequest {
  String username;
  String name;

  UserCreateRequest({
    required this.username,
    required this.name,
  });

  factory UserCreateRequest.fromJson(Map<String, dynamic> json) =>
      UserCreateRequest(
        username: json["username"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
      };
}
