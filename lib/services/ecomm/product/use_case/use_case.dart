import 'package:flu_go_jwt/services/ecomm/product/gateway/product_gateway.dart';
import 'package:flu_go_jwt/services/ecomm/product/domain/domain_product.dart';

class UseCase implements ProductGateway {
  final ProductGateway gateway;

  UseCase({required this.gateway});

  @override
  Future<(List<Product>?, Exception?)> getProducts() {
    return gateway.getProducts();
  }
}
