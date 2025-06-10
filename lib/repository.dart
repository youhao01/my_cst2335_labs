import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class DataRepository {
  static String loginName = "";
  static String firstName = "";
  static String lastName = "";
  static String phone = "";
  static String email = "";

  static final _prefs = EncryptedSharedPreferences();

  // Load from EncryptedSharedPreferences
  static Future<void> loadData() async {
    try {
      loginName = await _prefs.getString("loginName") ?? "";
      firstName = await _prefs.getString("firstName") ?? "";
      lastName = await _prefs.getString("lastName") ?? "";
      phone = await _prefs.getString("phone") ?? "";
      email = await _prefs.getString("email") ?? "";
    } catch (e) {
      // Error handling
    }
  }

  // Save to EncryptedSharedPreferences
  static Future<void> saveData() async {
    await _prefs.setString("loginName", loginName);
    await _prefs.setString("firstName", firstName);
    await _prefs.setString("lastName", lastName);
    await _prefs.setString("phone", phone);
    await _prefs.setString("email", email);
  }
}
