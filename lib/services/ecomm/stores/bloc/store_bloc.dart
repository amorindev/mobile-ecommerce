import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flu_go_jwt/services/ecomm/stores/core/core.dart';
import 'package:flu_go_jwt/services/ecomm/stores/gateway/store_gateway.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc(StoreGateway provider)
      : super(const StoreStateInitial(isLoading: false)) {
    on<StoreEventGetAll>((event, emit) async {
      emit(const StoresStateLoaded(
        stores: null,
        exception: null,
        isLoading: false,
      ));

      final (stores, respErr) = await provider.getAll(
        accessToken: event.accessToken,
      );

      emit(const StoresStateLoaded(
        stores: null,
        exception: null,
        isLoading: false,
      ));

      if (respErr != null) {
        emit(StoresStateLoaded(
          stores: null,
          exception: respErr,
          isLoading: false,
        ));
        return;
      }

      emit(StoresStateLoaded(
        stores: stores,
        exception: null,
        isLoading: false,
      ));
    });
  
  on<StoreEventReset>((event, emit) {
    emit(const StoreStateInitial(isLoading: false));
  });
  }
}
