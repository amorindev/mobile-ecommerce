import 'package:flu_go_jwt/services/auth/gateway/auth_gateway.dart';
import 'package:flu_go_jwt/services/auth/models/model.dart';

class UseCase implements AuthGateway {
  final AuthGateway gateway;

  const UseCase({required this.gateway});

  @override
  Future<(User?, Exception?)> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    return gateway.signUp(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  @override
  Future<(Session?, Exception?)> signIn({
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
  Future<(Session?, String?)> googleSignIn({required String tokenId}) {
    return gateway.googleSignIn(tokenId: tokenId);
  }

  @override
  Future<String?> sendEmailVerification({required String email}) {
    return gateway.sendEmailVerification(email: email);
  }

  @override
  Future<Exception?> signOut({required String refreshToken}) {
    return gateway.signOut(refreshToken: refreshToken);
  }

  @override
  Future<Session?> get currentUser => throw UnimplementedError();
  
  @override
  Future<Exception?> sendForgotPassword({required String email}) {
    return gateway.sendForgotPassword(email: email);
  }
}
