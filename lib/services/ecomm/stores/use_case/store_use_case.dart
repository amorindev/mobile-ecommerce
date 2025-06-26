import 'package:flu_go_jwt/services/ecomm/stores/core/core.dart';
import 'package:flu_go_jwt/services/ecomm/stores/gateway/store_gateway.dart';

class StoreUseCase implements StoreGateway {
  final StoreGateway gateway;

  StoreUseCase({required this.gateway});
  @override
  Future<(List<StoreResponse>?, Exception?)> getAll({
    required String accessToken,
  }) {
    return gateway.getAll(accessToken: accessToken);
  }
}
