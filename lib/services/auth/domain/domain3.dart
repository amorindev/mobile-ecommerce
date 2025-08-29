// To parse this JSON data, do
//
//     final session = sessionFromJson(jsonString);

/* import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flu_go_jwt/services/auth/models/user.dart'; */

// * Para http por que dio parse internamente

/* AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson()); */
// * ----------------------------------------

// * sign-in - sign-up-verify-otp y sign-up retornan entidades similares
// * una propuesat seria crear entidades diferentes
// * los campos diferentes agregarlos como obcional
/* class AuthResponse extends Equatable {
  final String provider;
  final String accessToken;
  final String refreshToken;
  final User user;

  const AuthResponse({
    required this.provider,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
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
  List<Object?> get props => [accessToken, refreshToken, user];
}
 */
//ver valores nulos generados desde el backend, flujo
class Test {
  String? test;
}
