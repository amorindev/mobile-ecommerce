import 'package:flu_go_jwt/services/onboarding/domain/domain_onboarding.dart';

abstract class OnboardingGateway {
  // me parece que no necesita accestoken
  Future<(List<OnboardingResponse>?, Exception?)> getOnboardings();
}
