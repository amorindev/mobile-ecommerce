part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  final bool isLoading;
  final String? loadingText;
  const OrderState({
    required this.isLoading,
    this.loadingText,
  });

  @override
  List<Object?> get props => [isLoading, loadingText];
}

// ver si los initial necesitan loading
class OrderStateInitial extends OrderState {
  const OrderStateInitial({required super.isLoading});
}

// debo hacer un State por cada uno de mis pecisiones
// o mi backend de momento solo uno
// * order create
class OrderStatePay extends OrderState {
  final Exception? exception;
  //ver que se va a guardar en el bloc y que se va a guardar
  // en el state de cada uno o en ambos
  // no es strig por que al agregar internacionalizacion se debe hacer lo mas cerca a la ui -ver
  // ver donde agregarlo de momento que sea global - si me parece que todos neceitarán
  // if estado es state pay - dentro - si  estado es  sueccess -mostramos
  final bool? success;
  //final OrderResp? orderCreate;
  final double? total;

  final String? deliveryType; // ! crear uuna entidad order
  final Pickup? pickup;
  final Delivery? delivery;
  final double shippingCost; // ver su copyWith
  final double? subTotal;
  final List<ProductItem>? products;
  const OrderStatePay({
    this.shippingCost = 6.2,
    //required this.orderCreate,
    required this.deliveryType,
    required this.products,
    required this.pickup,
    required this.delivery,
    required this.subTotal,
    required this.total,
    required this.success,
    required this.exception,
    required super.isLoading,
    super.loadingText,
  });

  OrderStatePay copyWith({
    List<ProductItem>? products,
    double? subTotal,
    double? shippingCost,
    double? total,
    String? deliveryType,
    Pickup? pickup,
    Delivery? delivery,
    Exception? exception,
    bool? isLoading,
    bool? success,
  }) {
    return OrderStatePay(
      shippingCost: shippingCost ?? this.shippingCost,
      products: products ?? this.products,
      subTotal: subTotal ?? this.subTotal,
      total: total ?? this.total,
      deliveryType: deliveryType ?? this.deliveryType,
      pickup: pickup ?? this.pickup,
      delivery: delivery ?? this.delivery,
      exception: exception,
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
    );
  }

  @override
  List<Object?> get props => [
        deliveryType,
        products,
        pickup,
        delivery,
        subTotal,
        total,
        success,
        exception,
        isLoading,
        loadingText,
      ];
}

class OrderStateLoaded extends OrderState {
  final List<OrderResp>? orders;
  final Exception? exception;
  const OrderStateLoaded({
    required this.orders,
    required this.exception,
    required super.isLoading,
    super.loadingText,
  });
  @override
  List<Object?> get props => [
        orders,
        exception,
        isLoading,
        loadingText,
      ];
}

// * Puede ser
/*
class OrderEventGetDetail extends OrderEvent {
  final String orderId;
  final String accessToken;

  const OrderEventGetDetail({
    required this.orderId,
    required this.accessToken,
  });
}
 */
