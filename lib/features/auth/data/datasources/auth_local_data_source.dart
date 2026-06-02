import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDataSource {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  static const String _accessTokenKey = 'access_token';

  // Securely saves the token strings onto the device hard drive
  Future<String?> saveAccessToken({required String token}) async {
    await _secureStorage.write(key: _accessTokenKey, value: token);
    return token;
  }

  // Reads the access token securely from local storage
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: _accessTokenKey);
  }

  // Clears out the token records when a user signs out
  Future<void> clearAccessToken() async {
    return await _secureStorage.delete(key: _accessTokenKey);
  }
}
