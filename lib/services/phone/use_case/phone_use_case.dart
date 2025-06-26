import 'package:flu_go_jwt/services/phone/core/core.dart';
import 'package:flu_go_jwt/services/phone/gateway/phone_gateway.dart';

class PhoneUseCase implements PhoneGateway {
  final PhoneGateway gateway;

  PhoneUseCase({required this.gateway});
  @override
  Future<(PhoneResp?, Exception?)> create({
    required String accessToken,
    required String countryCode,
    required String countryISOCode,
    required String number,

  }) {
    return gateway.create(
      accessToken: accessToken,
      countryCode: countryCode,
      countryISOCode: countryISOCode,
      number: number,
    );
  }

  @override
  Future<(List<PhoneResp>?, Exception?)> getAll({required accessToken}) {
    return gateway.getAll(
      accessToken: accessToken,
    );
  }
}
