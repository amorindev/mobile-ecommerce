
import 'package:bloc/bloc.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/services/auth/gateway/auth_gateway.dart';

Future<void> verifyEmailOtpBlocEvent(
  AuthEventVerifyEmailOtp event,
  Emitter<AuthState> emit,
  AuthGateway provider,
) async {

  
}