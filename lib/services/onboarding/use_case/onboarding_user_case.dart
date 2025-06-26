import 'package:flu_go_jwt/services/onboarding/gateway/onboarding_gateway.dart';
import 'package:flu_go_jwt/services/onboarding/model/model.dart';

class OnboardingUserCase implements OnboardingGateway {
  final OnboardingGateway gateway;

  OnboardingUserCase({required this.gateway});
  @override
  Future<(List<OnboardingResponse>?, Exception?)> getOnboardings() {
    return gateway.getOnboardings();
  }
}
