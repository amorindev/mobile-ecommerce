part of 'order_bloc.dart';

// * que pasa si hay varios métodos de pago
// * como hacer primero crear el order en el backend
// * despues crear el payment intent y despues en stripe
// * crear los 3 en un mismo evento o separado

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderEventReset extends OrderEvent{}

class OrderEventSetProductItems extends OrderEvent {
  final List<ProductItem> products;
  final double subtotal;
  const OrderEventSetProductItems({
    required this.subtotal,
    required this.products,
  });
}

class OrderEventSetShippingInfo extends OrderEvent {
  final String deliveryType;
  final Pickup? pickup;
  final Delivery? delivery;

  const OrderEventSetShippingInfo({
    required this.deliveryType,
    required this.pickup,
    required this.delivery,
  });
}

class OrderEventSetPayment extends OrderEvent {}

// * Crear la ordene en el backend
class OrderEventCreate extends OrderEvent {
  // seria como el agregate
  final String accessToken;
  //final double total;
  //final String deliveryType;
  //final String d;
  //! como hacer con
  const OrderEventCreate({
    required this.accessToken,
    //required this.total,
  });
}

class OrderEventGetAll extends OrderEvent {
  final String accessToken;

  const OrderEventGetAll({required this.accessToken});
}
