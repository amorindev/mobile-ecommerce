part of 'cart_bloc.dart';

@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartEventAddToCart extends CartEvent {
  final ProductItem product;
  const CartEventAddToCart({required this.product});
}

class CartEventChangeAmount extends CartEvent {
  // de momento le pasare toda la entidad
  final ProductItem product;
  final int amount;
  const CartEventChangeAmount({required this.product, required this.amount});
}

class CartEventRemoveFromCart extends CartEvent {
  final ProductItem product;
  const CartEventRemoveFromCart({required this.product});
}

// limpiar cache para que  el nuevo usuario que se registre e inicie session
// no vea los datos de otra cuentas
class CartEventResetCart extends CartEvent {}