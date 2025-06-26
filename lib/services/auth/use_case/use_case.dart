import 'package:flu_go_jwt/services/auth/gateway/auth_gateway.dart';
import 'package:flu_go_jwt/services/auth/models/modelv2.dart';

class UseCase implements AuthGateway {
  final AuthGateway gateway;

  const UseCase({required this.gateway});

  @override
  Future<(AuthResponse?, Exception?)> signUp({
    required String email,
    required String password,
    required String confirmPassword,
    String? name,
  }) {
    return gateway.signUp(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  @override
  Future<Exception?> sendEmailVerificarionOTP({required email}) {
    return gateway.sendEmailVerificarionOTP(email: email);
  }

  @override
  Future<(AuthResponse?, Exception?)> signUpVerifyOtp({
    required String otpId,
    required String otpCode,
    required String email,
  }) {
    return gateway.signUpVerifyOtp(
      otpId: otpId,
      otpCode: otpCode,
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
      rememberMe: rememberMe,
    );
  }

  @override
  Future<(User?, Exception?)> getUser({required String accessToken}) {
    return gateway.getUser(accessToken: accessToken);
  }

  @override
  Future<(Session?, Exception?)> refreshToken({
    required String refreshToken,
  }) {
    return gateway.refreshToken(
      refreshToken: refreshToken,
    );
  }

  @override
  Future<Exception?> signOut({required String refreshToken}) {
    return gateway.signOut(refreshToken: refreshToken);
  }

  @override
  Future<(AuthResponse?, String?)> googleSignIn({required String tokenId}) {
    return gateway.googleSignIn(tokenId: tokenId);
  }

  @override
  Future<Exception?> sendEmailVerification({required String email}) {
    return gateway.sendEmailVerification(email: email);
  }

  @override
  Future<Exception?> sendForgotPassword({required String email}) {
    return gateway.sendForgotPassword(email: email);
  }

  @override
  Future<Exception?> deleteAccount({required accessToken, required password}) {
    return gateway.deleteAccount(accessToken: accessToken, password: password);
  }

  /* @override
  Future<(AuthResponse?, Exception?)> getSession(
      {required String accessToken}) {
    return gateway.getSession(accessToken: accessToken);
  }
 */
  @override
  Future<(String?, Exception?)> enableTwoFaSms({
    required String accessToken,
    required String phoneId,
  }) {
    return gateway.enableTwoFaSms(
      accessToken: accessToken,
      phoneId: phoneId,
    );
  }

  @override
  Future<(User?, Exception?)> enableTwoFaSmsVerifyOtp({
    required String accessToken,
    required String otpId,
    required String otpCode,
  }) {
    return gateway.enableTwoFaSmsVerifyOtp(
      accessToken: accessToken,
      otpId: otpId,
      otpCode: otpCode,
    );
  }

  @override
  Future<(AuthResponse?, Exception?)> twoFaSmsVerifyOtp({
    required String otpId,
    required String otpCode,
  }) {
    return gateway.twoFaSmsVerifyOtp(otpId: otpId, otpCode: otpCode);
  }
}
