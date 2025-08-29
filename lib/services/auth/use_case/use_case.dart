import 'package:flu_go_jwt/services/auth/gateway/auth_gateway.dart';
import 'package:flu_go_jwt/services/auth/domain/domainv2.dart';

class UseCase implements AuthGateway {
  final AuthGateway gateway;

  const UseCase({required this.gateway});

  @override
  Future<(String?, Exception?)> enableMfaSms({
    required String accessToken,
    required String phoneId,
  }) {
    return gateway.enableMfaSms(
      accessToken: accessToken,
      phoneId: phoneId,
    );
  }

  @override
  Future<(AuthResponse?, Exception?)> refreshToken({
    required String refreshToken,
  }) {
    return gateway.refreshToken(
      refreshToken: refreshToken,
    );
  }

  @override
  Future<Exception?> resendVerifyEmailOtp({
    required String email,
  }) {
    return gateway.resendVerifyEmailOtp(
      email: email,
    );
  }

  @override
  Future<Exception?> resendVerifyEnableMfaSmsOtp({
    required String email,
  }) {
    return gateway.resendVerifyEnableMfaSmsOtp(
      email: email,
    );
  }

  @override
  Future<Exception?> resendVerifyMfaSmsOtp({
    required String email,
  }) {
    return gateway.resendVerifyMfaSmsOtp(
      email: email,
    );
  }

  @override
  Future<(AuthResponse?, Exception?)> signIn({
    required String email,
    required String password,
    bool? rememberMe,
  }) {
    return gateway.signIn(
      email: email,
      password: password,
    );
  }

  @override
  Future<Exception?> signOut({
    required String refreshToken,
  }) {
    return gateway.signOut(
      refreshToken: refreshToken,
    );
  }

  @override
  Future<(AuthResponse?, Exception?)> signUpOtp({
    String? name,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    return gateway.signUpOtp(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  @override
  Future<(AuthResponse?, Exception?)> verifyEmailOtp({
    required String otpId,
    required String otpCode,
    required String email,
  }) {
    return gateway.verifyEmailOtp(
      otpId: otpId,
      otpCode: otpCode,
      email: email,
    );
  }

  @override
  Future<(User?, Exception?)> verifyEnableMfaSmsOtp({
    required String accessToken,
    required String otpId,
    required String otpCode,
  }) {
    return gateway.verifyEnableMfaSmsOtp(
      accessToken: accessToken,
      otpId: otpId,
      otpCode: otpCode,
    );
  }

  @override
  Future<(AuthResponse?, Exception?)> verifyMfaSmsOtp({
    required String otpId,
    required String otpCode,
  }) {
    return gateway.verifyMfaSmsOtp(
      otpId: otpId,
      otpCode: otpCode,
    );
  }
}
