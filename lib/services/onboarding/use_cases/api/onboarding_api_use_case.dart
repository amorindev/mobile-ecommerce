import 'package:dio/dio.dart';
import 'package:flu_go_jwt/services/onboarding/gateway/onboarding_gateway.dart';
import 'package:flu_go_jwt/services/onboarding/domain/domain_onboarding.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OnboardingApiUseCase implements OnboardingGateway {
  late final String _baseURL;
  late final Dio _dio;

  OnboardingApiUseCase() {
    final url = dotenv.env['API_URL'];
    if (url == "" || url == null) {
      throw Exception("environment variable API_URL is not set");
    }
    _baseURL = url;
    _dio = Dio(BaseOptions(
      validateStatus: (status) => status! <= 500,
    ));
  }
  @override
  Future<(List<OnboardingResponse>?, Exception?)> getOnboardings() async {
    try {
      final resp = await _dio.get("$_baseURL/v1/onboardings2");
      if (resp.statusCode == 200) {
        final onboardingsResp = OnboardingsResponse.fromJson(resp.data);
        return (onboardingsResp.onboardings, null);
      }
      //print("tttt ${resp.data}");
      // * ver el tema que status vamos a manejar 200 y configurar dio
      // * para que no se caiga la app
      /* print("======================3");
      print("!!!!!!!!!!!!!!!!!!!");
      print(resp.statusCode);
      print(resp.data['message']);
      print("!!!!!!!!!!!!!!!!!!!!!!!"); */
      String errMsg;
      errMsg = resp.data['message'] ?? "err-msg-empty-getOnboardings";
      return (null, Exception(errMsg));
    } catch (e) {
      //print("errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr ${e.toString()}");
      return (null, Exception(e.toString()));
    }
  }
}
