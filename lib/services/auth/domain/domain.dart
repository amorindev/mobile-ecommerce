/* import 'dart:convert';

import 'package:equatable/equatable.dart';

AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse extends Equatable {
  final String provider;
  final String? accessToken;
  final String? refreshToken;
  final String? otpId;
  final User user;
  

  const AuthResponse({
    required this.provider,
    required this.accessToken,
    required this.refreshToken,
    required this.otpId,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        provider: json["provider"],
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        otpId: json["otp_id"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "provider": provider,
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "otp_id": otpId,
        "user": user.toJson(),
      };

  @override
  List<Object?> get props => [provider, accessToken, refreshToken, otpId, user];

  AuthResponse copyWith({
    String? provider,
    String? accessToken,
    String? refreshToken,
    String? otpId,
    User? user,
  }) {
    return AuthResponse(
      provider: provider ?? this.provider,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      otpId: otpId ?? this.otpId,
      user: user ?? this.user,
    );
  }
}

class User extends Equatable {
  final String id;
  final String email;
  final bool emailVerified;
  final List<String> roles;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
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
        roles: List<String>.from(json["roles"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "email_verified": emailVerified,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  @override
  List<Object?> get props =>
      [id, email, emailVerified, roles, createdAt, updatedAt];
}
 */