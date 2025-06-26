/* class PaymentResponse {
    final String id;
    final String userId;
    final int amount;
    final String currency;
    final String status;
    final String paymentMethod;
    final dynamic providerPaymentId;
    final DateTime createdAt;
    final DateTime updatedAt;

    PaymentResponse({
        required this.id,
        required this.userId,
        required this.amount,
        required this.currency,
        required this.status,
        required this.paymentMethod,
        required this.providerPaymentId,
        required this.createdAt,
        required this.updatedAt,
    });

    factory PaymentResponse.fromJson(Map<String, dynamic> json) => PaymentResponse(
        id: json["id"],
        userId: json["user_id"],
        amount: json["amount"],
        currency: json["currency"],
        status: json["status"],
        paymentMethod: json["payment_method"],
        providerPaymentId: json["provider_payment_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "amount": amount,
        "currency": currency,
        "status": status,
        "payment_method": paymentMethod,
        "provider_payment_id": providerPaymentId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
 */