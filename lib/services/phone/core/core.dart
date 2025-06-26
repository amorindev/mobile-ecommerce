// To parse this JSON data, do
//
//     final phonesResp = phonesRespFromJson(jsonString);

/* import 'dart:convert';

PhonesResp phonesRespFromJson(String str) {
    final jsonData = json.decode(str);
    return PhonesResp.fromJson(jsonData);
}

String phonesRespToJson(PhonesResp data) {
    final dyn = data.toJson();
    return json.encode(dyn);
} */

class PhonesResp {
  final List<PhoneResp> phones;

  PhonesResp({
    required this.phones,
  });

  factory PhonesResp.fromJson(Map<String, dynamic> json) => PhonesResp(
        phones: List<PhoneResp>.from(
            json["phones"].map((x) => PhoneResp.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "phones": List<dynamic>.from(phones.map((x) => x.toJson())),
      };
}

class PhoneResp {
  final String id;
  final String userId;
  final String number;
  final String countryCode;
  final bool isDefault;
  final bool isVerified;
  final String countryISOCode;
  final String createdAt;
  final String updatedAt;

  PhoneResp({
    required this.id,
    required this.userId,
    required this.number,
    required this.countryCode,
    required this.countryISOCode,
    required this.isDefault,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PhoneResp.fromJson(Map<String, dynamic> json) => PhoneResp(
        id: json["id"],
        userId: json["user_id"],
        number: json["number"],
        countryCode: json["country_code"],
        countryISOCode: json["country_iso_code"],
        isDefault: json["is_default"],
        isVerified: json["is_verified"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "number": number,
        "country_code": countryCode,
        "country_iso_code": countryCode,
        "is_default": isDefault,
        "is_verified": isVerified,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
