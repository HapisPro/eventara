import 'package:shared_preferences/shared_preferences.dart';

/// Service to manage persistent login state using SharedPreferences
class SharedPreferencesService {
  final SharedPreferences _preferences;

  SharedPreferencesService(this._preferences);

  static const String _keyLogin = "IS_LOGGED_IN";
  static const String _keyUserId = "USER_ID";
  static const String _keyUserEmail = "USER_EMAIL";
  static const String _keyUserName = "USER_NAME";

  /// Check if user is logged in
  bool? get isLogin => _preferences.getBool(_keyLogin);

  /// Get stored user ID
  String? get userId => _preferences.getString(_keyUserId);

  /// Get stored user email
  String? get userEmail => _preferences.getString(_keyUserEmail);

  /// Get stored user name/username
  String? get userName => _preferences.getString(_keyUserName);

  /// Mark user as logged in and store user data
  Future<void> login({String? userId, String? email, String? userName}) async {
    try {
      await _preferences.setBool(_keyLogin, true);
      if (userId != null) {
        await _preferences.setString(_keyUserId, userId);
      }
      if (email != null) {
        await _preferences.setString(_keyUserEmail, email);
      }
      if (userName != null) {
        await _preferences.setString(_keyUserName, userName);
      }
    } catch (e) {
      throw Exception("Failed to save login state: $e");
    }
  }

  /// Mark user as logged out and clear user data
  Future<void> logout() async {
    try {
      await _preferences.setBool(_keyLogin, false);
      await _preferences.remove(_keyUserId);
      await _preferences.remove(_keyUserEmail);
      await _preferences.remove(_keyUserName);
    } catch (e) {
      throw Exception("Failed to clear login state: $e");
    }
  }

  /// Clear all stored preferences
  Future<void> clearAll() async {
    try {
      await _preferences.clear();
    } catch (e) {
      throw Exception("Failed to clear preferences: $e");
    }
  }
}
