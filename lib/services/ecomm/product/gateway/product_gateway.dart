import 'package:flu_go_jwt/services/ecomm/product/domain/domain_product.dart';

abstract class ProductGateway {
  // mejor devolver solo la lista de productos
  //Future<(ProductsResponse?, Exception?)> getProducts();
  Future<(List<Product>?, Exception?)> getProducts();
}
