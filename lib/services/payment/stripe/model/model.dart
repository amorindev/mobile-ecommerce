// To parse this JSON data, do
//
//     final paymentIntentResponse = paymentIntentResponseFromJson(jsonString);

/* import 'dart:convert';

PaymentIntentResponse paymentIntentResponseFromJson(String str) => PaymentIntentResponse.fromJson(json.decode(str));

String paymentIntentResponseToJson(PaymentIntentResponse data) => json.encode(data.toJson()); */

class PaymentIntentResponse {
    final String clientSecret;

    PaymentIntentResponse({
        required this.clientSecret,
    });

    factory PaymentIntentResponse.fromJson(Map<String, dynamic> json) => PaymentIntentResponse(
        clientSecret: json["client_secret"],
    );

    Map<String, dynamic> toJson() => {
        "client_secret": clientSecret,
    };
}
