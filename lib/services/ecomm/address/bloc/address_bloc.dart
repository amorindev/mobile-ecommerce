import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flu_go_jwt/services/ecomm/address/core/core.dart';
import 'package:flu_go_jwt/services/ecomm/address/gateway/address_gateway.dart';
import 'package:flutter/widgets.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc(AddressGateway provider) : super(const AddressStateInitial(isLoading: false)) {
    on<AddressEventCreate>((event, emit) async {
      if (state is AddressStateLoaded) {
        final currentState = state as AddressStateLoaded;
        emit(currentState.copyWith(isLoading: true));

        final (resp, respErr) = await provider.create(
          accessToken: event.accessToken,
          label: event.label,
          addressLine: event.addressLine,
          state: event.state,
          country: event.country,
          city: event.city,
          postalCode: event.postalCode,
          latitude: event.latitude,
          longitude: event.longitude,
        );

        emit(currentState.copyWith(isLoading: false));

        if (respErr != null) {
          emit(currentState.copyWith(exception: respErr));
          return;
        }
        // caules la loigica
        // al crear un producto y mostrarlo
        // crear el producto en el backend y retornar los productos
        // crear el producto y retornar el producto y hacer una pecision get product
        // o crear el producto retornarlo desde el backend y agregarlo al bloc o ala lista y refrescar la pantalla.
        // *tenemos un inconveniernte necesitamos los dos estados Create para obtener el producto y GetAllDonde estan todos los productos
        // * 1. pasar la lista de adddress mediante Create
        // * 2. como es un crud seguimos a cartbloc la lista lo dejamo en el estado global

        if (currentState.addresses == null) {
          final List<AddressResponse> newAddresses = [resp!];
          emit(currentState.copyWith(
            addresses: newAddresses,
            lastCreated: resp,
            isSuccess: true,
          ));

          return;
        }
        // necesito la lista de address para agreagr
        // * de momento llamare otra ves al envento getall lo ideal seria agregar a la lista sin hacer otra peticion
        final List<AddressResponse> addresses = [...currentState.addresses!, resp!];
        emit(currentState.copyWith(addresses: addresses, lastCreated: resp, isSuccess: true));
        return;
      }

      // * Opcion dos luego preguntar a gpt
      //debugPrint("que hago aqui");
      // ! cuando se agrega un nuevo elemento serefresca toda la pantalla o solo el ultimo elemento
    });

    on<AddressEventGetAll>((event, emit) async {
      // en los get all no va ser necesario copy with por que segun el flujo  no tenemos datos
      emit(const AddressStateLoaded(
        addresses: null,
        exception: null,
        isLoading: false,
        lastCreated: null,
        isSuccess: null,
      ));

      // o err o exp respErr
      final (resp, respErr) = await provider.getAll(
        accessToken: event.accessToken,
      );

      emit(const AddressStateLoaded(
        addresses: null,
        exception: null,
        isLoading: false,
        lastCreated: null,
        isSuccess: null,
      ));

      if (respErr != null) {
        emit(AddressStateLoaded(
          addresses: null,
          exception: respErr,
          isLoading: false,
          lastCreated: null,
          isSuccess: null,
        ));
        return;
      }

      // verificar si  es nulo el addresses
      // o en que capa validar eso
      emit(AddressStateLoaded(
        addresses: resp,
        exception: null,
        isLoading: false,
        lastCreated: null,
        isSuccess: null,
      ));
    });

    on<AddressEventReset>((event, emit) {
      emit(const AddressStateInitial(isLoading: false));
    });
  }
}
