import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flu_go_jwt/services/ecomm/product/domain/domain_product_item.dart';
import 'package:flutter/foundation.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  // ? cual es mejor marcar comolista basía o null
  // *en products
  // * si lo mantenemos aque no sabemos como usarlo desde
  // * los widgets, es diferente al Session
  // * creo  que una es privada y el otro no
  int? total; // * todavia no se sabe aqui o en el State
  CartBloc() : super(const CartStateProducts(products: null, subTotal: 0.0)) {
    // !-----------------
    // ! sacar del estado global al lista de productos y usar CartLoaded guiarse de address state
    // !-----------------
    // ? se puede ejecutar código aquí

    // ! el usuario pued aumentar desde el carrito
    // ! cantidad por el precion
    // ! ver el bug
    on<CartEventAddToCart>((event, emit) {
      /* if (state.products == null) {
        List<ProductProduct> products = [event.product];
        // ? aqui deveria ser?
        int t;
        if (total == null) {
          //total = event.product.amount!;
          // no es necesarion por que no es ? pero lo dejo
          t = event.amount!;
        } else {

          //total = total! + event.product.amount!;
          t = state.amount + event.product.amount!;
        }

        emit(CartStateProducts(products: products, total: t));
      } */

      /* if (state is CartStateProducts) {
        final currentState = state as CartStateProducts;

        if (event.product.stock <= 0) {
          emit(currentState.copyWith(
            exp: Exception("Producto con insuficiente stock"),
          ));
          return;
        }

        if (currentState.products == null) {
          final t = event.product.quantity! * event.product.price;

          final List<ProductItem> products = [event.product];
          emit(CartStateProducts(products: products, subTotal: t));
          return;
        }

        for (var pItens in currentState.products!) {
          if (pItens.id == event.product.id) {
            final productsCart = [...currentState.products!];
            emit(CartStateProducts(
              products: productsCart,
              subTotal: currentState.subTotal,
              exp: Exception(
                'producto ya fue añadido al carrito',
              ),
            ));
            return;
          }
        }

        final productsCart = [...currentState.products!, event.product];
        double t = 0;
        for (var p in productsCart) {
          t = t + (p.price * p.quantity!);
        }
        emit(
          CartStateProducts(
            products: productsCart,
            subTotal: t,
          ),
        );
      } */
      // CartStateProducts todo inicializado encero o quitar CartStateInitial
      if (state is CartStateProducts) {
        final currentState = state as CartStateProducts;

        if (event.product.stock <= 0) {
          emit(currentState.copyWith(
            exp: Exception("producto con insuficiente stock"),
          ));
          return;
        }
        if (currentState.products == null) {
          final t = event.product.quantity! * event.product.price;

          final List<ProductItem> products = [event.product];
          emit(CartStateProducts(products: products, subTotal: t));
          return;
        }

        // segun el flujo no debería ser nulo
        for (var pItens in currentState.products!) {
          if (pItens.id == event.product.id) {

            final productsCart = [...currentState.products!];
            emit(CartStateProducts(
              products: productsCart,
              subTotal: currentState.subTotal,
              exp: Exception(
                'producto ya fue añadido al carrito',
              ),
            ));
            return;
          }
        }

        final productsCart = [...currentState.products!, event.product];
        double t = 0;
        for (var p in productsCart) {
          t = t + (p.price * p.quantity!);
        }

        emit(
          CartStateProducts(
            products: productsCart,
            subTotal: t,
          ),
        );
      }
    });

    on<CartEventRemoveFromCart>((event, emit) {
      if (state is CartStateProducts) {
        final cartState = state as CartStateProducts;
        final List<ProductItem> updatedProducts = [];

        double t = 0.0;
        for (var p in cartState.products!) {
          if (p.id == event.product.id) {
            continue;
          } else {
            t += p.price * p.quantity!;
            updatedProducts.add(p);
          }
        }

        emit(CartStateProducts(
          products: updatedProducts,
          subTotal: t,
        ));
      }
    });

    on<CartEventChangeAmount>((event, emit) {
      if (state is CartStateProducts) {
        final cartState = state as CartStateProducts;
        final List<ProductItem> updatedProducts = [];

        double t = 0.0;
        for (var p in cartState.products!) {
          if (p.id == event.product.id) {
            // Copiamos el producto con la nueva cantidad
            final updatedProduct = p.copyWith(quantity: event.amount);
            t += updatedProduct.price * updatedProduct.quantity!;
            updatedProducts.add(updatedProduct);
          } else {
            t += p.price * p.quantity!;
            updatedProducts.add(p);
          }
        }

        emit(CartStateProducts(
          products: updatedProducts,
          subTotal: t,
        ));
      }
    });

    on<CartEventResetCart>((event, emit) {
      emit(const CartStateProducts(products: null,subTotal: 0.0));
    });
  }
}
