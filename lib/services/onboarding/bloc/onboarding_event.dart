part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class OnboardingEventReset extends OnboardingEvent{}

class OnboardingEventGetOnboardings extends OnboardingEvent {
  const OnboardingEventGetOnboardings();
}

// para marcar como usuario no nuevo
class OnboardingEventIsNotNewUser extends OnboardingEvent {
  const OnboardingEventIsNotNewUser();
}
