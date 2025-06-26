import 'package:dio/dio.dart';
import 'package:flu_go_jwt/services/ecomm/address/core/core.dart';
import 'package:flu_go_jwt/services/ecomm/address/gateway/address_gateway.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AddressApiUseCase implements AddressGateway {
  late final String _baseURL;
  late final Dio _dio;

  AddressApiUseCase() {
    final url = dotenv.env['API_URL'];
    if (url == "" || url == null) {
      throw Exception("address environment variable API_URL is not set");
    }
    _baseURL = url;
    _dio = Dio(BaseOptions(
      validateStatus: (status) => status! <= 500,
    ));
  }

  @override
  Future<(AddressResponse?, Exception?)> create({
    required String accessToken,
    required String label,
    required String addressLine,
    required String state,
    required String country,
    required String city,
    required String postalCode,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
        //'Accept': 'application/json',
        //'Custom-Header': 'valor_personalizado',
      };
      // * igual para phones
      // * al crear un address se debe marcar como por defecto - no por que es otro accion del usuario mejor maantenerlo separado
      final data = {
        'label': label,
        'address_line': addressLine,
        'postal_code': postalCode,
        'state': state,
        'country': country,
        'city': city,
        'is_default': false,
        'latitude':latitude,
        'longitude': longitude,
      };

      final resp = await _dio.post(
        "$_baseURL/v1/addresses",
        data: data,
        options: Options(headers: headers),
      );

      // ! falta retornar la entidawd
      if (resp.statusCode == 200) {
        // !nombres cortor address resp ver
        final address = AddressResponse.fromJson(resp.data);
        return (address, null);
      }
      // * controlar todos los que permitiste en alcrear DIO <=500 asi para todas las funciones
      if (resp.statusCode == 404) {
        return (null, Exception("order 404 página no econtrada"));
      }
      String errMsg;
      errMsg = resp.data['message'] ?? "address-err-msg-not-found";
      return (null, Exception(errMsg));
    } catch (e) {
      return (null, Exception(e.toString()));
    }
  }

  @override
  Future<(List<AddressResponse>?, Exception?)> getAll({
    required String accessToken,
  }) async {
    try {
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };

      final resp = await _dio.get(
        "$_baseURL/v1/addresses",
        options: Options(headers: headers),
      );
      if (resp.statusCode == 200) {
        final addressesResp = AddressesResponse.fromJson(resp.data);
        return (addressesResp.addresses, null);
      }
      if (resp.statusCode == 404) {
        return (null, Exception("404 página no encontrada"));
      }
      String errMsg;
      errMsg = resp.data['message'] ?? "err-msg-empty-getproducts";
      return (null, Exception(errMsg));
    } catch (e) {
      return (null, Exception(e.toString()));
    }
  }
}
