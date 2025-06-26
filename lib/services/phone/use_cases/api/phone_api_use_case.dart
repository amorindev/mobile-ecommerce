import 'package:dio/dio.dart';
import 'package:flu_go_jwt/services/phone/core/core.dart';
import 'package:flu_go_jwt/services/phone/gateway/phone_gateway.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PhoneApiUseCase implements PhoneGateway {
  late final String _baseURL;
  late final Dio _dio;

  PhoneApiUseCase() {
    final url = dotenv.env['API_URL'];
    if (url == "" || url == null) {
      throw Exception("phone environment variable API_URL is not set");
    }
    _baseURL = url;
    // ! ver hasta donde se va abarcar hasta 500?
    // ! si no la app se congelará
    _dio = Dio(
      BaseOptions(
        validateStatus: (status) => status! <= 500,
      ),
    );
  }

  @override
  Future<(PhoneResp?, Exception?)> create({
    required String accessToken,
    required String countryCode,
    required String countryISOCode,
    required String number,
  }) async {
    try {
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
        //'Accept': 'application/json',
        //'Custom-Header': 'valor_personalizado',
      };
      // usar to json personalizado asi como en backend json personalizados en flutter es tijson
      final data = {
        'country_code': countryCode,
        'number': number,
        'country_iso_code': countryISOCode,
      };

      final resp = await _dio.post(
        "$_baseURL/v1/phones",
        data: data,
        options: Options(headers: headers),
      );

      if (resp.statusCode == 200) {
        // !nombres cortor phone resp ver
        final phone = PhoneResp.fromJson(resp.data);
        return (phone, null);
      }
      if (resp.statusCode == 404) {
        return (null, Exception("phone 404 página no econtrada"));
      }

      String errMsg;
      errMsg = resp.data['message'] ?? "phone-err-msg-not-found";

      return (null, Exception(errMsg));
    } catch (e) {
      return (null, Exception(e.toString()));
    }
  }

  @override
  Future<(List<PhoneResp>?, Exception?)> getAll({
    required accessToken,
  }) async {
    try {
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
        //'Accept': 'application/json',
        //'Custom-Header': 'valor_personalizado',
      };

      final resp = await _dio.get(
        "$_baseURL/v1/phones",
        options: Options(headers: headers),
      );

      if (resp.statusCode == 200) {
        final phonesResp = PhonesResp.fromJson(resp.data);
        return (phonesResp.phones, null);
      }
      if (resp.statusCode == 404) {
        return (null, Exception("404 página no encontrada"));
      }
      String errMsg;
      errMsg = resp.data['message'] ?? "err-msg-empty-getphones";
      return (null, Exception(errMsg));
    } catch (e) {
      return (null, Exception(e.toString()));
    }
  }
}
