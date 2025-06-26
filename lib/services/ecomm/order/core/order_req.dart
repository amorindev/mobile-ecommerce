// To parse this JSON data, do
//
//     final orderRequest = orderRequestFromJson(jsonString);


/* import 'dart:convert';

OrderRequest orderRequestFromJson(String str) =>
    OrderRequest.fromJson(json.decode(str));

String orderRequestToJson(OrderRequest data) => json.encode(data.toJson());
 */
// * de momento se llamará order request pero debe ser como el solo Product
// * las entidades de request deben tener toJson si o si
// * si es response si o si from json
// ! userId desde el token
/* class OrderRequest {
  final double total;
  final List<ProductItem> productItems;

  OrderRequest({
    required this.total,
    required this.productItems,
  }); */

// ! esto estubo comentado


 /*  factory OrderRequest.fromJson(Map<String, dynamic> json) => OrderRequest(
        userId: json["user_id"],
        total: json["total"],
        productItems: List<ProductItem>.from(
            json["product_items"].map((x) => ProductItem.fromJson(x))),
      ); */

// ! esto estubo comentado
  /* Map<String, dynamic> toJson() => {
        "user_id": userId,
        "total": total,
        "product_items":
            List<dynamic>.from(productItems.map((x) => x.toJson())),
      }; */
  
  /*  Map<String, dynamic> toJsonCreateOrder() => {
        "total": total,
        "product_items":
            List<dynamic>.from(productItems.map((x) => x.toOrderJson())),
      }; */
/* } */

