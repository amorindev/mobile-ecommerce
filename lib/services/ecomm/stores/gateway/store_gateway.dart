import 'package:flu_go_jwt/services/ecomm/stores/core/core.dart';

abstract class StoreGateway {
  Future<(List<StoreResponse>?, Exception?)> getAll({
    required String accessToken,
  });
}
