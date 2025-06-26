// * no seria mejor mientidad_use_case y MientidaUseCase clase para no complicarnos
import 'package:flu_go_jwt/services/ecomm/order/core/resp.dart';
import 'package:flu_go_jwt/services/ecomm/order/gateway/order_gateway.dart';
import 'package:flu_go_jwt/services/ecomm/product/model/product_item.dart';

class UseCase implements OrderGateway {
  final OrderGateway gateway;

  UseCase({required this.gateway});

  @override
  Future<(OrderResp?, Exception?)> create({
    required String accessToken,
    required double total,
    required String deliveryType,
    required List<ProductItem> productItems,
    required Pickup? pickup,
    required Delivery? delivery,
    required String paymentMethod,
    required String currency,
  }) {
    return gateway.create(
      accessToken: accessToken,
      total: total,
      deliveryType: deliveryType,
      productItems: productItems,
      pickup: pickup,
      delivery: delivery,
      currency: currency,
      paymentMethod: paymentMethod,
    );
  }

  @override
  Future<(List<OrderResp>?, Exception?)> getAll({
    required String accessToken,
  }) {
    return gateway.getAll(
      accessToken: accessToken,
    );
  }
}
