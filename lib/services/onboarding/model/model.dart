// To parse this JSON data, do
//
//     final onboardingsResponse = onboardingsResponseFromJson(jsonString);

import 'dart:convert';

OnboardingsResponse onboardingsResponseFromJson(String str) => OnboardingsResponse.fromJson(json.decode(str));

String onboardingsResponseToJson(OnboardingsResponse data) => json.encode(data.toJson());

class OnboardingsResponse {
    final List<OnboardingResponse> onboardings;

    OnboardingsResponse({
        required this.onboardings,
    });

    factory OnboardingsResponse.fromJson(Map<String, dynamic> json) => OnboardingsResponse(
        onboardings: List<OnboardingResponse>.from(json["onboardings"].map((x) => OnboardingResponse.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "onboardings": List<dynamic>.from(onboardings.map((x) => x.toJson())),
    };
}

class OnboardingResponse {
    final String id;
    final String imgUrl;
    final String title;
    final String text;
    final DateTime expiresAt;
    final DateTime createdAt;

    OnboardingResponse({
        required this.id,
        required this.imgUrl,
        required this.title,
        required this.text,
        required this.expiresAt,
        required this.createdAt,
    });

    factory OnboardingResponse.fromJson(Map<String, dynamic> json) => OnboardingResponse(
        id: json["id"],
        imgUrl: json["img_url"],
        title: json["title"],
        text: json["text"],
        expiresAt: DateTime.parse(json["expires_at"]),
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "img_url": imgUrl,
        "title": title,
        "text": text,
        "expires_at": expiresAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
    };
}
