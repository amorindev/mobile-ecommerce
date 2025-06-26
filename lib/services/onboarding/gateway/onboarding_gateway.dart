import 'package:flu_go_jwt/services/onboarding/model/model.dart';

abstract class OnboardingGateway {
  // me parece que no necesita accestoken
  Future<(List<OnboardingResponse>?, Exception?)> getOnboardings();
}
