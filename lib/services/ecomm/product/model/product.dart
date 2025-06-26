import 'package:flu_go_jwt/services/ecomm/product/model/product_item.dart';
import 'package:flu_go_jwt/services/ecomm/product/model/variation.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final String imgUrl;
  final String status;
  final String sku;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ProductItem> products;
  final List<Variation>? variations;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imgUrl,
    required this.status,
    required this.sku,
    required this.createdAt,
    required this.updatedAt,
    required this.products,
    required this.variations,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        imgUrl: json["img_url"],
        status: json["status"],
        sku: json["sku"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        products: List<ProductItem>.from(json["product_items"].map(
          (x) => ProductItem.fromJson(x),
        )),
        variations: json["variations"] == null
            ? []
            : List<Variation>.from(json["variations"]!.map(
                (x) => Variation.fromJson(x),
              )),
      );

  /* Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "img_url": imgUrl,
        "status": status,
        "sku": sku,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "products": List<dynamic>.from(products.map(
          (x) => x.toJson(),
        )),
        "variations": variations == null
            ? []
            : List<dynamic>.from(variations!.map(
                (x) => x.toJson(),
              )),
      }; */
  
  
}