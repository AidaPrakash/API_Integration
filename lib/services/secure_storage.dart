import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {

  static const String accessToken = "ACCESSTOKEN";
  static const String emailId = "EMAILID";
  static const String password = "PASSWORD";

  FlutterSecureStorage secureStore = new FlutterSecureStorage();

  setAuthorization(String accessTokenValue, String emailIdValue, String passwordValue) async {
    await secureStore.write(key: accessToken, value: accessTokenValue);
    await secureStore.write(key: emailId, value: emailIdValue);
    await secureStore.write(key: password, value: passwordValue);
  }

  getAccessToken() async {
    return await secureStore.read(key: accessToken) ?? "";
  }

  getEmaiId() async {
    return await secureStore.read(key: emailId) ?? "";
  }

  getPassword() async {
    return await secureStore.read(key: password) ?? "";
  }

  clearToken() async {
    return await secureStore.deleteAll();
  }

}