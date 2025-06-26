import 'package:flu_go_jwt/services/phone/core/core.dart';

abstract class PhoneGateway {
  Future<(PhoneResp?, Exception?)> create({
    required String accessToken,
    required String countryCode,
    required String number,
    required String countryISOCode,
  });

  Future<(List<PhoneResp>?, Exception?)> getAll({
    required accessToken,
  });
}
