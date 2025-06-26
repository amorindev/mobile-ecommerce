import 'package:flu_go_jwt/services/ecomm/product/core/option_resp.dart';

class ProductItemResponse {
  // ! ProductResponse y tener dos
  // ! entidades como en le backend
  // ! una que recibe los datos  y el otro las procesa
  // *---------------------
  // ! mejor separar response de producct
  // ! dos entidades 
  // ! hacer un copywih para cambiar
  // ! el amount recuerda debe ser imatable
  // *---------------------
  
  String? productGroupName;
  int? amount;
  // !----
  final String id;
  final int stock;
  final int discount;
  final int rating;
  final double price;
  final String imgUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<OptionResponse>? options;

  ProductItemResponse({
    // ! ----------
    this.productGroupName,
    this.amount,
    // !------------
    required this.id,
    required this.stock,
    required this.discount,
    required this.rating,
    required this.price,
    required this.imgUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.options,
  });

  factory ProductItemResponse.fromJson(Map<String, dynamic> json) => ProductItemResponse(
        id: json["id"],
        stock: json["stock"],
        discount: json["discount"],
        rating: json["rating"],
        price: (json["price"] as num).toDouble(),
        imgUrl: json["img_url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        options: json["options"] == null
            ? []
            : List<OptionResponse>.from(
                json["options"]!.map((x) => OptionResponse.fromJson(x))),
      );

  /* Map<String, dynamic> toJson() => {
        "id": id,
        "stock": stock,
        "discount": discount,
        "rating": rating,
        "price": price,
        "img_url": imgUrl,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
      }; */
}

extension ProductItemCopy on ProductItemResponse {
  ProductItemResponse copyWith({
    String? productGroupName,
    int? amount,
    String? id,
    int? stock,
    int? discount,
    int? rating,
    double? price,
    String? imgUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<OptionResponse>? options,
  }) {
    return ProductItemResponse(
      productGroupName: productGroupName ?? this.productGroupName,
      amount: amount ?? this.amount,
      id: id ?? this.id,
      stock: stock ?? this.stock,
      discount: discount ?? this.discount,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      imgUrl: imgUrl ?? this.imgUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      options: options ?? this.options,
    );
  }
}

