import 'package:flu_go_jwt/services/auth/local-storage/model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionSecureStorage {
  // ? que pasa si ya existen genera error si es asi como actualizarlos simplemente
  // ? como para el refresh token
  // ! ver  si puede generar error
  static const _storage = FlutterSecureStorage();

  static const _keyRefreshtoken = 'refresh-token';

  static Future<String?> saveRefreshToken(String refreshtoken) async {
    try {
      await _storage.write(key: _keyRefreshtoken, value: refreshtoken);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String?> getRefreshToken() async {
    try {
      await _storage.read(key: _keyRefreshtoken);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String?> clearRefreshToken() async {
    try {
      await _storage.delete(key: _keyRefreshtoken);
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
