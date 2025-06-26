// To parse this JSON data, do
//
//     final addressResponse = addressResponseFromJson(jsonString);

/* import 'dart:convert';

AddressResponse addressResponseFromJson(String str) {
    final jsonData = json.decode(str);
    return AddressResponse.fromJson(jsonData);
}

String addressResponseToJson(AddressResponse data) {
    final dyn = data.toJson();
    return json.encode(dyn);
} */

class AddressesResponse {
  //final List<AddressResponse> addresses;
  final List<AddressResponse>? addresses;

  AddressesResponse({
    required this.addresses,
  });

  factory AddressesResponse.fromJson(Map<String, dynamic> json) =>
      /* AddressesResponse(
        addresses: List<AddressResponse>.from(
            json["addresses"].map((x) => AddressResponse.fromJson(x))),
      ); */

      AddressesResponse(
        addresses: json["addresses"] == null
            ? null
            : List<AddressResponse>.from(
                json["addresses"].map((x) => AddressResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        //"addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
        "addresses": addresses?.map((x) => x.toJson()).toList(),
      };
}

// ! Falta storeid
class AddressResponse {
  final String id;
  final String userId;
  final String label;
  final String addressLine;
  final double latitude;
  final double longitude;
  final String country;
  final String city;
  final String state;
  final String postalCode;
  final bool isDefault;
  final String createdAt;
  final String updatedAt;

  AddressResponse({
    required this.city,
    required this.state,
    required this.id,
    required this.userId,
    required this.label,
    required this.addressLine,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.postalCode,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      AddressResponse(
        id: json["id"],
        userId: json["user_id"],
        label: json["label"],
        addressLine: json["address_line"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postalCode: json["postal_code"],
        isDefault: json["is_default"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "label": label,
        "address_line": addressLine,
        "latitude": latitude,
        "longitude": longitude,
        "city": city,
        "state": state,
        "country": country,
        "postal_code": postalCode,
        "is_default": isDefault,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
