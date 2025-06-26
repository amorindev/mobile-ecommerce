import 'package:dio/dio.dart';
import 'package:flu_go_jwt/services/ecomm/stores/core/core.dart';
import 'package:flu_go_jwt/services/ecomm/stores/gateway/store_gateway.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StoreApiUseCase implements StoreGateway {
  late final String _baseURL;
  late final Dio _dio;

  StoreApiUseCase() {
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
  Future<(List<StoreResponse>?, Exception?)> getAll({
    required String accessToken,
  }) async {
    try {
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
        //'Accept': 'application/json',
        //'Custom-Header': 'valor_personalizado',
      };

      final resp = await _dio.get(
        "$_baseURL/v1/stores",
        options: Options(headers: headers),
      );

      if (resp.statusCode == 200) {

        final storesResp = StoresResponse.fromJson(resp.data);
        return (storesResp.stores, null);
      }
      if (resp.statusCode == 404) {

        return (null, Exception("404 página no encontrada"));
      }

      String errMsg;
      errMsg = resp.data['message'] ?? "err-msg-empty-getstores";
      return (null, Exception(errMsg));
    } catch (e) {
      return (null, Exception(e.toString()));
    }
  }
}
