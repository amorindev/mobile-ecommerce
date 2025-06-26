part of 'cart_bloc.dart';

@immutable
abstract class CartState extends Equatable {
  //List<ProductProduct> = [] o List<ProductProduct>?
  /* final bool isLoading;
  final String? loadingText; */
  const CartState(
      /* {
    required this.isLoading,
    this.loadingText,
  } */
      );

  /* @override
  List<Object?> get props => [isLoading, loadingText]; */

  @override
  List<Object?> get props => [];
}

/* class CartStateInitial extends CartState{}  */

class CartStateProducts extends CartState {
  // * este error es cauando intentamos agregar
  // * un producto ya añadido o que no tiene sotck
  // * para que no choque con otros errores
  // * se puede validar con el manejo de errores del tostring
  final Exception? exp;
  final List<ProductItem>? products;
  final double subTotal;
  const CartStateProducts({
    this.exp,
    required this.products,
    // ! este es el problema de ponerlo en el state y no enel bloc
    required this.subTotal,
  });

  CartStateProducts copyWith({
    Exception? exp,
    List<ProductItem>? products,
    double? subTotal,
  }) {
    return CartStateProducts(
      products: products ?? this.products,
      subTotal: subTotal ?? this.subTotal,
      exp: exp ?? this.exp,
    );
  }

  @override
  List<Object?> get props => [exp, products, subTotal];
}
