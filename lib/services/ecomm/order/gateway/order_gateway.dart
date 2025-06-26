import 'package:flu_go_jwt/services/ecomm/order/core/resp.dart';
import 'package:flu_go_jwt/services/ecomm/product/model/product_item.dart';

// TODO poner los repectivos midlewares en el backend
// * no se debe retornar ningun response sino solo Order asi para los demás gateways
// * ver que el Order sea compatible para las dos primeras funciones
abstract class OrderGateway {
  // ! o pasar primiticos y la lsita de productItems
  Future<(OrderResp?, Exception?)> create({
    required String accessToken,
    required double total,
    required String deliveryType,
    required List<ProductItem> productItems,
    required Pickup? pickup,
    required Delivery? delivery,
    required String paymentMethod,
    required String currency, // enum me parece mejor
  });

  // tokens ver todos los que usaran paginacion
  // userid del token
  Future<(List<OrderResp>?, Exception?)> getAll({
    required String accessToken,
  });
}
