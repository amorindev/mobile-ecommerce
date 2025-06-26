part of 'onboarding_bloc.dart';

abstract class OnboardingState extends Equatable {
  final bool isLoading;
  final String? loadingText;
  const OnboardingState({
    required this.isLoading,
    this.loadingText,
  });

  @override
  List<Object?> get props => [
        isLoading,
        loadingText,
      ];
}

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial({
    required super.isLoading,
    super.loadingText,
  });
}

class OnboardingStateGetOnboardings extends OnboardingState {
  final Exception? exception;
  final List<OnboardingResponse>? onboardings;
  const OnboardingStateGetOnboardings({
    required this.exception,
    required this.onboardings,
    required super.isLoading,
  });
  @override
  List<Object?> get props => [exception, onboardings,isLoading];
}
