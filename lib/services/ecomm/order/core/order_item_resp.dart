/* class OrderItemResponse {
    final String id;
    final String orderId;
    final String productId;
    final int quantity;
    final int price;

    OrderItemResponse({
        required this.id,
        required this.orderId,
        required this.productId,
        required this.quantity,
        required this.price,
    });

    factory OrderItemResponse.fromJson(Map<String, dynamic> json) => OrderItemResponse(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
        "price": price,
    };
}
 */