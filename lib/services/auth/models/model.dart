// To parse this JSON data, do
//
//     final session = sessionFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

// * Para http por que dio parse internamente
Session sessionFromJson(String str) => Session.fromJson(json.decode(str));
String sessionToJson(Session data) => json.encode(data.toJson());
// * ----------------------------------------

// ? debe ser immutable o extender de equtable? pra el bloc
// mejor userCredential por que la sesion es el accesstoke y refreshtoken
class Session extends HiveObject with EquatableMixin {
  String provider;
  String accessToken;
  String refreshToken;
  User user;

  Session({
    required this.provider,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        provider: json["provider"],
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "provider": provider,
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "user": user.toJson(),
      };

  @override
  // TODO: implement props
  List<Object?> get props => [provider, accessToken, refreshToken, user];
}

class User extends HiveObject with EquatableMixin {
  String id;
  String email;
  bool emailVerified;
  List<Role> roles;
  // ? o timestamp pegaria mi entidd a  protobuf?
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.email,
    required this.emailVerified,
    required this.roles,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        emailVerified: json["email_verified"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "email_verified": emailVerified,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  @override
  List<Object?> get props => [id, email, email, roles, createdAt, updatedAt];
}

// falta hive?
class Role extends Equatable {
  String id;
  String name;

  Role({
    required this.id,
    required this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  List<Object?> get props => [id, name];
}

//ver valores nulos generados desde el backend, flujo
class Test {
  String? test;
}
