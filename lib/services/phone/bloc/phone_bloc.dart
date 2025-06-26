import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flu_go_jwt/services/phone/core/core.dart';
import 'package:flu_go_jwt/services/phone/gateway/phone_gateway.dart';

part 'phone_event.dart';
part 'phone_state.dart';

class PhoneBloc extends Bloc<PhoneEvent, PhoneState> {
  PhoneBloc(PhoneGateway provider)
      : super(const PhoneStateInitial(isLoading: false)) {
    on<PhoneEventCreate>((event, emit) async {
      // ! tiene que ser con copiwith para que no elimine los productos cargado
      if (state is PhoneStateLoaded) {
        final currentState = state as PhoneStateLoaded;
        emit(currentState.copyWith(
          isLoading: true,
        ));

        final (resp, respErr) = await provider.create(
          accessToken: event.accessToken,
          countryCode: event.countryCode,
          countryISOCode: event.countryISOCode,
          number: event.number,
        );

        emit(currentState.copyWith(isLoading: false));

        if (respErr != null) {
          emit(currentState.copyWith(exception: respErr));
          return;
        }

        if (currentState.phones == null) {
          final List<PhoneResp> newPhones = [resp!];
          emit(currentState.copyWith(phones: newPhones));
          return;
        }
        // necesito la lista de phones para agreagr
        // * de momento llamare otra ves al envento getall lo ideal seria agregar a la lista sin hacer otra peticion - esto pasaba cuando usaba dos estados que recuerde mira address tambien
        final List<PhoneResp> phones = [...currentState.phones!, resp!];
        emit(currentState.copyWith(phones: phones));
        return;
      }

      // * Opcion dos luego preguntar a gpt
      //debugPrint("que hago aqui");
    });
    on<PhoneEventGetAll>((event, emit) async {
      emit(const PhoneStateLoaded(
        phones: null,
        exception: null,
        isLoading: true,
      ));

      final (resp, respErr) = await provider.getAll(
        accessToken: event.accessToken,
      );

      emit(const PhoneStateLoaded(
        phones: null,
        exception: null,
        isLoading: false,
      ));

      if (respErr != null) {
        emit(PhoneStateLoaded(
          phones: null,
          exception: respErr,
          isLoading: false,
        ));
        return;
      }
      //debugPrint(resp.toString());
      //debugPrint(resp.toString());
      //debugPrint(resp.toString());
      // verificar si  es nulo el phones
      // o en que capa validar eso
      emit(PhoneStateLoaded(
        phones: resp,
        exception: null,
        isLoading: false,
      ));
    });

    on<PhoneEventReset>((event, emit) {
      emit(const PhoneStateInitial(isLoading: false));
    });
  }
}
