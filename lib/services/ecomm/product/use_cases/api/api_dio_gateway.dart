import 'package:dio/dio.dart';
import 'package:flu_go_jwt/services/ecomm/product/gateway/product_gateway.dart';
import 'package:flu_go_jwt/services/ecomm/product/domain/domain_product.dart';
import 'package:flu_go_jwt/services/ecomm/product/core/response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiDioGateway implements ProductGateway {
  late final String _baseURL;
  late final Dio _dio;

  ApiDioGateway() {
    // ves que se duplica, lo mismo para
    // * o podira ser crear uno para todos
    final url = dotenv.env['API_URL'];
    if (url == "" || url == null) {
      throw Exception("environment variable API_URL is not set");
    }
    _baseURL = url;
    _dio = Dio(BaseOptions(
      validateStatus: (status) => status! <= 500,
    ));
  }

  @override
  Future<(List<Product>?, Exception?)> getProducts() async {
    try {
      final resp = await _dio.get("$_baseURL/v1/products2");
      if (resp.statusCode == 200) {
        final productsResp = ProductsResponse.fromJson(resp.data);
        return (productsResp.products, null);
      }
      //print(resp.statusCode);
      String errMsg;
      errMsg = resp.data['message'] ?? "err-msg-empty-getproducts";
      return (null, Exception(errMsg));
    } catch (e) {
      return (null, Exception(e.toString()));
    }
  }
}
