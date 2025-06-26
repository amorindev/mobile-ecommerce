/* // To parse this JSON data, do
//
//     final orderResponse = orderResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flu_go_jwt/services/ecomm/order/core/order_item_resp.dart';
import 'package:flu_go_jwt/services/ecomm/order/core/payment_resp.dart';

OrderResponse orderResponseFromJson(String str) => OrderResponse.fromJson(json.decode(str));

String orderResponseToJson(OrderResponse data) => json.encode(data.toJson());

class OrderResponse {
    final String id;
    final String userId;
    final List<OrderItemResponse> orderItems;
    final int total;
    final PaymentResponse payment;
    final DateTime createdAt;

    OrderResponse({
        required this.id,
        required this.userId,
        required this.orderItems,
        required this.total,
        required this.payment,
        required this.createdAt,
    });

    factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        id: json["id"],
        userId: json["user_id"],
        orderItems: List<OrderItemResponse>.from(json["order_items"].map((x) => OrderItemResponse.fromJson(x))),
        total: json["total"],
        payment: PaymentResponse.fromJson(json["payment"]),
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "total": total,
        "payment": payment.toJson(),
        "createdAt": createdAt.toIso8601String(),
    };
}


 */