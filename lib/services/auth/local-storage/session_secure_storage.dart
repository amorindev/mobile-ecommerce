import 'package:flu_go_jwt/services/auth/local-storage/model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionSecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _keyAccessToken = 'access-token';
  static const _keyRefreshtoken = 'refresh-token';
  static const _newUserkey = 'new-user';
  //static const _darkmode = 'dark-mode';

  static Future saveAccessToken(String accessToken) async {
    await _storage.write(key: _keyAccessToken, value: accessToken);
  }

  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _keyAccessToken);
  }

  static Future saveRefreshToken(String refreshtoken) async {
    await _storage.write(key: _keyRefreshtoken, value: refreshtoken);
  }

  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _keyRefreshtoken);
  }

  // que pasa si ya existen genera error si es asi como actualizarlos simplemente
  // como para el refresh token
  static Future saveTokens(String accessToken, String refreshtoken) async {
    try {
      await _storage.write(key: _keyAccessToken, value: accessToken);
      await _storage.write(key: _keyRefreshtoken, value: refreshtoken);
    } catch (e) {
      throw Exception("save Tokens err: $e");
    }
    //await _storage.write(key: _keyRefreshtoken, value: refreshtoken);
  }

  static Future<SessionLocalStg> getTokens() async {
    try {
      final accessToken = await _storage.read(key: _keyAccessToken);
      final refreshToken = await _storage.read(key: _keyRefreshtoken);
      return SessionLocalStg(accessToken: accessToken, refreshToken: refreshToken);
    } catch (e) {
      throw Exception("get Tokens err: $e");
    }
  }

  static Future clearTokens() async {
    try {
      await _storage.delete(key: _keyAccessToken);
      await _storage.delete(key: _keyAccessToken);
    } catch (e) {
      throw Exception("clear tokens err $e");
    }
  }

  // "true" "false"
  static Future saveNewUser(String isNewUser) async {
    try {
      await _storage.write(key: _newUserkey, value: isNewUser);
    } catch (e) {
      throw Exception("saveNewUser err $e");
    }
  }

  static Future<String?> isNewUser() async {
    try {
      return await _storage.read(key: _newUserkey);
    } catch (e) {
      throw Exception("isNewUser err $e");
    }
  }
}
