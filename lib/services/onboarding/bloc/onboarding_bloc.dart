import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flu_go_jwt/services/auth/local-storage/session_secure_storage.dart';
import 'package:flu_go_jwt/services/onboarding/gateway/onboarding_gateway.dart';
import 'package:flu_go_jwt/services/onboarding/model/model.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc(OnboardingGateway gateway)
      : super(const OnboardingInitial(isLoading: false)) {
    on<OnboardingEventGetOnboardings>((event, emit) async {
      emit(const OnboardingStateGetOnboardings(
        exception: null,
        onboardings: null,
        isLoading: true,
      ));
      

      final (resp, respErr) = await gateway.getOnboardings();
      // si se necesita no ppuedes cambiar todos los estados  a laves
      emit(const OnboardingStateGetOnboardings(
          exception: null,
          onboardings: null,
          isLoading: false,
        ));
      if (respErr != null) {
        emit(OnboardingStateGetOnboardings(
          onboardings: null,
          exception: respErr,
          isLoading: false,
        ));
        return;
      }
      if (resp == null) {
        emit(OnboardingStateGetOnboardings(
          isLoading: false,
          exception: Exception("no hay onboardings para mostrar"),
          onboardings: null,
        ));
        return;
      }

      // ahora si seria mejor separarlo
      // Onboarding shared preferences
      await SessionSecureStorage.saveNewUser("false");

      emit(OnboardingStateGetOnboardings(
        exception: null,
        onboardings: resp,
        isLoading: false,
      ));
    });
    on<OnboardingEventIsNotNewUser>((event, emit) {
      /// asignar que ya no es new user
      /// puede ser al obtener mas facil
      /// o despues que ve todos los onboarding
      /// a no ser que precion skip
      /// mejor denort de getOnboardings
    });
  }
}
