import 'package:flu_go_jwt/services/payment/stripe/gateway/stripe_gateway.dart';
import 'package:flu_go_jwt/services/payment/stripe/model/model.dart';

// ! cual es mejor crear la order desde mi api y
// ! retornar la order creada y hacer otra consulta para
// ! crear el payment intent, o crear el order y retornar
// * Mejor lo creo desde aqui para poder reutilizarlo
class StripeUseCase implements StripeGateway {
  // ? dara error de la misma manera para todos _marcar como privado lo que es privado
  // ? vere e cuales mas aplica
  final StripeGateway _gateway;

  StripeUseCase({required StripeGateway gateway}) : _gateway = gateway;
  @override
  Future<(PaymentIntentResponse?, Exception?)> createPaymentIntent({
    required accessToken,
    required double amount,
    required String currency,
    required Map<String,String> metadata,
  }) async {
    return _gateway.createPaymentIntent(
      accessToken: accessToken,
      amount: amount,
      currency: currency,
      metadata: metadata,
    );
  }
}
