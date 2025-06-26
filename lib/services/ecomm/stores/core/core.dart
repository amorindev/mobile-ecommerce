// To parse this JSON data, do
//
//     final storesResponse = storesResponseFromJson(jsonString);

/* import 'dart:convert';

StoresResponse storesResponseFromJson(String str) {
    final jsonData = json.decode(str);
    return StoresResponse.fromJson(jsonData);
}

String storesResponseToJson(StoresResponse data) {
    final dyn = data.toJson();
    return json.encode(dyn);
} */

class StoresResponse {
  final List<StoreResponse> stores;

  StoresResponse({
    required this.stores,
  });

  factory StoresResponse.fromJson(Map<String, dynamic> json) => StoresResponse(
        stores: List<StoreResponse>.from(
          json["stores"].map((x) => StoreResponse.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "stores": List<dynamic>.from(stores.map((x) => x.toJson())),
      };
}

class StoreResponse {
  final String id;
  final String name;
  final String description;
  final AddressStoreResponse address;

  StoreResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
  });

  factory StoreResponse.fromJson(Map<String, dynamic> json) => StoreResponse(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        address: AddressStoreResponse.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "address": address.toJson(),
      };
}

// TODO Usar el address normal de momento usaré este 
class AddressStoreResponse {
  final String id;
  final String? userId;
  final String storeId;
  final String label;
  final String addressLine;
  final String city;
  final String state;
  final String country;
  final String postalCode;
  final double latitude;
  final double longitude;
  final bool isDefault;
  final String createdAt;
  final String updatedAt;

  AddressStoreResponse({
    required this.id,
    required this.userId,
    required this.storeId,
    required this.label,
    required this.addressLine,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AddressStoreResponse.fromJson(Map<String, dynamic> json) => AddressStoreResponse(
        id: json["id"],
        userId: json["user_id"],
        storeId: json["store_id"],
        label: json["label"],
        addressLine: json["address_line"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postalCode: json["postal_code"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        isDefault: json["is_default"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "store_id": storeId,
        "label": label,
        "address_line": addressLine,
        "city": city,
        "state": state,
        "country": country,
        "postal_code": postalCode,
        "latitude": latitude,
        "longitude": longitude,
        "is_default": isDefault,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
