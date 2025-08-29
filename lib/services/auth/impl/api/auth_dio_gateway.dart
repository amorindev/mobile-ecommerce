import 'package:dio/dio.dart';
import 'package:flu_go_jwt/services/auth/domain/domainv2.dart';
import 'package:flu_go_jwt/services/auth/exception/auth_exceptions.dart';
import 'package:flu_go_jwt/services/auth/gateway/auth_gateway.dart';

class AuthDioImpl implements AuthGateway {
  final Dio _dio;

  AuthDioImpl(this._dio);

  @override
  Future<(String?, Exception?)> enableMfaSms({required String accessToken, required String phoneId}) {
    // TODO: implement enableMfaSms
    throw UnimplementedError();
  }

  @override
  Future<(AuthResponse?, Exception?)> refreshToken({required String refreshToken}) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<Exception?> resendVerifyEmailOtp({
    required String email,
  }) async {
    try {
      final data = {'email': email};

      final resp = await _dio.post(
        "/v1/auth/resend-email-verification-otp",
        data: data,
      );

      if (resp.statusCode == 200) {
        return (null);
      }

      String errMsg;
      errMsg = resp.data['message'] ?? "err-msg-not-found-signupverifyotp";
      return (Exception(errMsg));
    } catch (e) {
      //print("ApiDioGateway - sendEmailVerificarionOTP exception $e");
      return (Exception(e.toString()));
    }
  }

  @override
  Future<Exception?> resendVerifyEnableMfaSmsOtp({required String email}) {
    // TODO: implement resendVerifyEnableMfaSmsOtp
    throw UnimplementedError();
  }

  @override
  Future<Exception?> resendVerifyMfaSmsOtp({required String email}) {
    // TODO: implement resendVerifyMfaSmsOtp
    throw UnimplementedError();
  }

  @override
  Future<(AuthResponse?, Exception?)> signIn({required String email, required String password, bool? rememberMe}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<Exception?> signOut({required String refreshToken}) {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<(AuthResponse?, Exception?)> signUpOtp({
    String? name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final data = {
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
        'name': name,
      };

      final resp = await _dio.post("/v1/auth/sign-up", data: data);
      //print(resp.statusCode);
      //print(resp.data);
      if (resp.statusCode == 200) {
        final user = AuthResponse.fromJson(resp.data);
        return (user, null);
      } else if (resp.statusCode == 400) {
        final data = resp.data;
        final message = data['msg'];
        final code = data['code'];
        if (code == EmailAlreadyInUseAuthException().toString()) {
          return (null, EmailAlreadyInUseAuthException());
        }
        return (null, GenericAuthException(code, message));
        // TODO lo siguiente manejarlo con handle http error
      } else if (resp.statusCode == 404) {
        return (null, Exception("page not found"));
      } else {
        return (null, GenericAuthException("",""));
      }
    } on DioException catch (e) {
      return (null, Exception(e.toString()));
    }
  }

  @override
  Future<(AuthResponse?, Exception?)> verifyEmailOtp({
    required String otpId,
    required String otpCode,
    required String email,
  }) async {
    try {
      final data = {"otp_id": otpId, "otp_code": otpCode, "email": email};

      final resp = await _dio.post(
        "/v1/auth/sign-up-verify-otp",
        data: data,
      );

      if (resp.statusCode == 200) {
        //print(resp.data);

        final authResp = AuthResponse.fromJson(resp.data);

        return (authResp, null);
      }
      // no se si esta bien final String txt; toma solo la primera asignacion?
      String errMsg;
      errMsg = resp.data['message'] ?? "err-msg-not-found-signupverifyotp";
      return (null, Exception(errMsg));
    } catch (e) {
      //print("ApiDioGateway - signUpVerifyOtp exception $e");
      return (null, GenericAuthException("",e.toString()));
    }
  }

  @override
  Future<(User?, Exception?)> verifyEnableMfaSmsOtp({
    required String accessToken,
    required String otpId,
    required String otpCode,
  }) {
    // TODO: implement verifyEnableMfaSmsOtp
    throw UnimplementedError();
  }

  @override
  Future<(AuthResponse?, Exception?)> verifyMfaSmsOtp({
    required String otpId,
    required String otpCode,
  }) {
    // TODO: implement verifyMfaSmsOtp
    throw UnimplementedError();
  }

}