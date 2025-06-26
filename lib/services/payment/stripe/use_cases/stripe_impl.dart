import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flu_go_jwt/services/payment/stripe/gateway/stripe_gateway.dart';
import 'package:flu_go_jwt/services/payment/stripe/model/model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StripeImpl implements StripeGateway {
  late final String _baseURL;
  late final Dio _dio;

  StripeImpl() {
    final url = dotenv.env['API_URL'];
    if (url == "" || url == null) {
      throw Exception("stripe service - variable API_URL is not set");
    }
    _baseURL = url;
    _dio = Dio(BaseOptions(
      validateStatus: (status) => status! <= 500,
    ));
  }
  @override
  Future<(PaymentIntentResponse?, Exception?)> createPaymentIntent({
    required accessToken,
    required double amount,
    required String currency,
    required Map<String, String> metadata,
  }) async {
    try {
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
        //'Accept': 'application/json',
        //'Custom-Header': 'valor_personalizado',
      };

      final data = {
        'amount': amount,
        'currency': currency,
        'metadata': metadata
      };
      final resp = await _dio.post(
        '$_baseURL/v1/payments/create-payment-intent',
        data: data,
        options: Options(headers: headers),
      );
      // * si se retorna *stripe.PaymentIntent,
      // * del backend podemos usar PaymentIntent.fromJson(json) como seria en dio
      if (resp.statusCode == 200) {
        //final clientSecret = response.data['client_secret']; oooo
        final decodedJson = json.decode(resp.data); // ? raro
        final pIntentResp = PaymentIntentResponse.fromJson(decodedJson);
        // esta esta mejor que los de arriba probar ambos
        //final pIntentResp = PaymentIntentResponse.fromJson(resp.data);
        return (pIntentResp, null);
      }
      // ! ver lo demas
      if (resp.statusCode == 400) {
        return (null, Exception("error400"));
      }
      String errMsg;
      errMsg = resp.data['message'] ?? "err-msg-empty-create-payment-itennt";
      return (null, Exception(errMsg));
    } on DioException catch (e) {
      return (null, Exception(e.toString()));
    }
  }
}
