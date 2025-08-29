import 'dart:convert';
import 'package:equatable/equatable.dart';

AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse extends Equatable {
  final Session? session;
  final Credentials? credentials;
  final String? otpId;
  final User user;

  const AuthResponse({
    required this.user,
    this.session,
    this.credentials,
    this.otpId,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        user: User.fromJson(json["user"]),
        session:
            json["session"] != null ? Session.fromJson(json["session"]) : null,
        credentials: json["credentials"] != null
            ? Credentials.fromJson(json["credentials"])
            : null,
        otpId: json["otp_id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        if (session != null) "session": session!.toJson(),
        if (credentials != null) "credentials": credentials!.toJson(),
        "otp_id": otpId,
      };

  @override
  List<Object?> get props => [user, session, credentials, otpId];
  AuthResponse copyWith({
    Session? session,
    Credentials? credentials,
    String? otpId,
    User? user,
  }) {
    return AuthResponse(
      user: user ?? this.user,
      session: session ?? this.session,
      credentials: credentials ?? this.credentials,
      otpId: otpId ?? this.otpId,
    );
  }
}

class Session extends Equatable {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;

  const Session({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "expires_in": expiresIn,
      };

  @override
  List<Object?> get props => [accessToken, refreshToken, expiresIn];

  Session copyWith({
    String? accessToken,
    String? refreshToken,
    int? expiresIn,
  }) {
    return Session(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresIn: expiresIn ?? this.expiresIn,
    );
  }
}

class Credentials extends Equatable {
  final String provider;

  const Credentials({
    required this.provider,
  });

  factory Credentials.fromJson(Map<String, dynamic> json) => Credentials(
        provider: json["provider"],
      );

  Map<String, dynamic> toJson() => {
        "provider": provider,
      };

  @override
  List<Object?> get props => [provider];
}

class User extends Equatable {
  final String id;
  final String email;
  final bool emailVerified;
  final String? username;
  final String? name;
  final List<String> roles;
  final String? phone;
  final bool phoneVerified;
  final String? imgUrl;
  final bool is2FAEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.email,
    required this.emailVerified,
    this.username,
    this.name,
    required this.roles,
    this.phone,
    required this.phoneVerified,
    this.imgUrl,
    required this.is2FAEnabled,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        emailVerified: json["email_verified"],
        username: json["username"],
        name: json["name"],
        roles: List<String>.from(json["roles"]),
        phone: json["phone"],
        phoneVerified: json["phone_verified"],
        imgUrl: json["img_url"],
        is2FAEnabled: json["is_two_fa_enabled"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "email_verified": emailVerified,
        "username": username,
        "name": name,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "phone": phone,
        "phone_verified": phoneVerified,
        "img_url": imgUrl,
        "is_2fa_enabled": is2FAEnabled,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        email,
        emailVerified,
        username,
        name,
        roles,
        phone,
        phoneVerified,
        imgUrl,
        is2FAEnabled,
        createdAt,
        updatedAt,
      ];
}
