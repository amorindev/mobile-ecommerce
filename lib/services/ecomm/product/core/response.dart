// To parse this JSON data, do
//
//     final productsResponse = productsResponseFromJson(jsonString);

/* Dio lo hace internamente solo se usa para http package 
import 'dart:convert';

ProductsResponse productsResponseFromJson(String str) => ProductsResponse.fromJson(json.decode(str));

String productsResponseToJson(ProductsResponse data) => json.encode(data.toJson()); */

import 'package:flu_go_jwt/services/ecomm/product/domain/domain_product.dart';

class ProductsResponse {
  final List<Product> products;

  ProductsResponse({
    required this.products,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      ProductsResponse(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );
/* 
  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      }; */
}
