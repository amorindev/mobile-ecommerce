import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flu_go_jwt/services/ecomm/product/gateway/product_gateway.dart';
import 'package:flu_go_jwt/services/ecomm/product/model/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(ProductGateway provider)
      : super(
          const ProductStateInitial(isLoading: false),
        ) {
    on<ProductEventGetProducts>((event, emit) async {
      emit(const ProductStateGetProducts(
        isLoading: true,
        exception: null,
        products: null,
      ));

      final (resp, respErr) = await provider.getProducts();

      // * Si tendría otro evento asíncrono mas abajo entonces pondira dentro del if respErr y donde el siguiente asyncrono para que el lading se muestre correctamente
      emit(const ProductStateGetProducts(
          isLoading: false,
          exception: null,
          products: null,
        ));

      if (respErr != null) {
        emit(ProductStateGetProducts(
          isLoading: false,
          exception: respErr,
          products: null,
        ));
        return;
      }

      // es necesario por que si no vino un error significa que hay  un producto ver flujo
      if (resp == null) {
        // * no se si un eror lo voy a dejar
        // * No hay productos para mostrar
        emit(
          ProductStateGetProducts(
            isLoading: false,
            exception: Exception("no hay productos para mostrar"),
            products: null,
          ),
        );
        return;
      }

      emit(
        ProductStateGetProducts(
          isLoading: false,
          exception: null,
          products: resp,
        ),
      );
    });

    on<ProductEventReset>((event, emit) {
      emit(const ProductStateInitial(isLoading: false));
    });
  }
}
