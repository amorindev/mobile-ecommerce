// ! que demas modelos se puede y debe crear
// To parse this JSON data, do
//
//     final authCreateRequest = authCreateRequestFromJson(jsonString);

/* import 'dart:convert';

import 'package:flu_go_jwt/services/auth/models/user.dart'; */

/* SignUpResponse signUpResponseFromJson(String str) => SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
    String provider;
    String otpId;
    User user;

    SignUpResponse({
        required this.provider,
        required this.otpId,
        required this.user,
    });

    factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        provider: json["provider"],
        otpId: json["otp_id"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "provider": provider,
        "otp_id": otpId,
        "user": user.toJson(),
    };
} */