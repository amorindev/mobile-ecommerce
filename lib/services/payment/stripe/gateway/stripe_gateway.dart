import 'package:flu_go_jwt/services/payment/stripe/model/model.dart';

abstract class StripeGateway {
  Future<(PaymentIntentResponse?, Exception?)> createPaymentIntent({
    required String accessToken,
    required double amount,
    required String currency,
    required Map<String,String> metadata,
  });
}
