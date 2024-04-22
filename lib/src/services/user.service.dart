import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {

  static Future<void> storeAuthToken(String token) async {
    await const FlutterSecureStorage().write(key: 'bearer', value: token);
  }

  static Future<String?> getAuthToken() async {
    return await const FlutterSecureStorage().read(key: 'bearer');
  }
}