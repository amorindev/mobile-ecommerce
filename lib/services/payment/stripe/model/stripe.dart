import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

// es otra forma con clases estáticas es una  sola instancia  igual furebase
// * Esto solo es el cliente ver donde ponerlo
class StripeProvider {
  static Dio? _dio;
  static String? _urlBase;
  //static late final String? _urlBase;
  // * es parecido al de firebase
  //static late final Stripe _stripe;

  static Future initialize() async {
    final String? url = dotenv.env['API_URL'];
    //_urlBase.isEmpty ? Cuándo usarlo
    if (url == null || _urlBase == "") {
      throw Exception("Api url is empty");
    }
    _urlBase = url;

    final apiKey = dotenv.env['STRIPE_PUBLIC_KEY'];
    if (apiKey == null || apiKey == "") {
      throw Exception("GoogleClientID is null");
    }

    _dio = Dio(BaseOptions(
      validateStatus: (status) => status! <= 500,
    ));

    Stripe.publishableKey = apiKey;
    Stripe.merchantIdentifier = "fernan"; // ? add .env merchant.com.tudominio
    await Stripe.instance.applySettings();
  }

  static Future payReview(String email, String? name) async {
    /* try {
       // * Crear el token de la tarjeta
      
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(email: email, name: name),
          ),
        ),
      );

      // almacenar el id

      // * Crear el PaymentIntent en el backend
      final headers = {'Content-Type': 'application/json'};
      final data = {
        'payment_method': paymentMethod.id,
        'amount': 1000, // en centavos $10.00 = 1000
        'currency': 'usd',
        'email': email
      };

      final response = await _dio.post(
        "$_urlBase/v1/auth/create-payment-intent",
        options: Options(headers: headers),
        data: data,
      );

      // * obtener respuesta
      //* final clientSecret = json.decode(response.body)['client_secret'];

      const String clientSecret = 'client-secret';

      // * Confimar el pago
      await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: clientSecret,
        data: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(email: email),
          ),
        ),
      ); */
    } catch (e) {} */
  }


}
