import 'package:dio/dio.dart';
import 'package:flu_go_jwt/services/ecomm/order/core/req.dart';
import 'package:flu_go_jwt/services/ecomm/order/core/resp.dart';
import 'package:flu_go_jwt/services/ecomm/order/gateway/order_gateway.dart';
import 'package:flu_go_jwt/services/ecomm/product/domain/domain_product_item.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OrderApiDioUseCase implements OrderGateway {
  late final String _baseURL;
  late final Dio _dio;

  OrderApiDioUseCase() {
    final url = dotenv.env['API_URL'];
    if (url == "" || url == null) {
      throw Exception("order environment variable API_URL is not set");
    }
    _baseURL = url;
    _dio = Dio(BaseOptions(
      validateStatus: (status) => status! <= 500,
    ));
  }

  @override
  Future<(OrderResp?, Exception?)> create({
    required String accessToken,
    required double total,
    required String deliveryType,
    required List<ProductItem> productItems,
    required Pickup? pickup,
    required Delivery? delivery,
    required String paymentMethod,
    required String currency,
  }) async {
    try {
      // * ver si se va a trnasformar OrderRequest de momento
      // * como hay listas mejor con tojson
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
        //'Accept': 'application/json',
        //'Custom-Header': 'valor_personalizado',
      };
      // ! revidar no se recibe OrderResponse y Request solo se quedan fuera no en el gateway

      // ! como hacer el seguimiento de lo que se esta enviando
      // ! grafana o tambien loguuer un postma para mi
      // ! frontend - otro saas el de fast alternativa a postma
      // ! ahi agregalo
      final data = OrderRequest(
        total: total,
        deliveryType: deliveryType,
        productItems: productItems,
        deliveryInfo: delivery,
        pickupInfo: pickup,
        payment: PaymentResp(
            id: "",
            orderId: "",
            currency: currency,
            status: "",
            paymentMethod: paymentMethod,
            providerPaymentId: "",
            createdAt: DateTime.now(),
            updatedAt: DateTime.now()),
      ).toJson();

      final resp = await _dio.post(
        "$_baseURL/v1/orders",
        data: data,
        options: Options(headers: headers),
      );
      if (resp.statusCode == 200) {
        final orderResp = OrderResp.fromJson(resp.data);
        // ! convertir a solo order
        return (orderResp, null);
      }
      // * controlar todos los que permitiste en alcrear DIO <=500 asi para todas las funciones
      if (resp.statusCode == 404) {
        return (null, Exception("order 404 página no econtrada"));
      }
      String errMsg;
      errMsg = resp.data['message'] ?? "order-err-nsg-not-found";
      return (null, Exception(errMsg));
    } on DioException catch (e) {
      return (null, Exception(e.toString()));
    } catch (e) {
      return (null, Exception(e.toString()));
    }
  }

  @override
  Future<(List<OrderResp>?, Exception?)> getAll({
    required String accessToken,
  }) async {
    try {
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };
      final resp = await _dio.get(
        "$_baseURL/v1/orders",
        options: Options(headers: headers),
      );

      if (resp.statusCode == 200) {
        //print(resp.data.toString());
        final ordersResp = OrdersResp.fromJson(resp.data);
        return (ordersResp.orders, null);
      }

      String errMsg;
      errMsg = resp.data['message'] ?? "err-msg-empty-getAllorders";
      return (null, Exception(errMsg));
    } catch (e) {
      //print("order - getAll - ${e.toString()}");

      return (null, Exception(e.toString()));
    }
  }
}
