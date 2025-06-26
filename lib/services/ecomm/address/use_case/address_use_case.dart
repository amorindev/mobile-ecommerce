import 'package:flu_go_jwt/services/ecomm/address/core/core.dart';
import 'package:flu_go_jwt/services/ecomm/address/gateway/address_gateway.dart';

class AddressUseCase implements AddressGateway {
  final AddressGateway gateway;

  AddressUseCase({required this.gateway});
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
  }) {
    return gateway.create(
      accessToken: accessToken,
      label: label,
      addressLine: addressLine,
      postalCode: postalCode,
      state: state,
      country: country,
      city: city,
      latitude: latitude,
      longitude: longitude,
    );
  }

  @override
  Future<(List<AddressResponse>?, Exception?)> getAll({
    required String accessToken,
  }) {
    return gateway.getAll(
      accessToken: accessToken,
    );
  }
}
