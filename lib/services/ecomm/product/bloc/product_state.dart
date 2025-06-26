part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  final bool isLoading;
  final String? loadingText;

  const ProductState({
    required this.isLoading,
    this.loadingText,
  });

  @override
  List<Object?> get props => [
        isLoading,
        loadingText,
      ];
}

class ProductStateInitial extends ProductState {
  const ProductStateInitial({
    required super.isLoading,
    super.loadingText,
  });
}

// tine nombre de envento cambialo
class ProductStateGetProducts extends ProductState {
  final List<Product>? products; // nuleable o [], y como validarlos
  final Exception? exception;

  const ProductStateGetProducts({
    required super.isLoading,
    required this.exception,
    required this.products,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        products,
        exception,
      ];
}
