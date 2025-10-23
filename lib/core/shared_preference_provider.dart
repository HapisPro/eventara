import 'package:eventara/data/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';

/// Provider to manage persistent login state across the app
class SharedPreferenceProvider extends ChangeNotifier {
  final SharedPreferencesService _service;

  SharedPreferenceProvider(this._service);

  bool _isLogin = false;
  String? _userId;
  String? _userEmail;
  String? _userName;
  String? _userRole;

  /// Check if user is currently logged in
  bool get isLogin => _service.isLogin ?? _isLogin;

  /// Get current user ID
  String? get userId => _service.userId ?? _userId;

  /// Get current user email
  String? get userEmail => _service.userEmail ?? _userEmail;

  /// Get current user name/username
  String? get userName => _service.userName ?? _userName;

  /// Get current user role
  String? get userRole => _service.userRole ?? _userRole;

  /// Initialize provider by loading saved preferences
  void init() {
    _isLogin = _service.isLogin ?? false;
    _userId = _service.userId;
    _userEmail = _service.userEmail;
    _userName = _service.userName;
    _userRole = _service.userRole;
    notifyListeners();
  }

  /// Login user and persist the state
  Future<void> login({
    String? userId,
    String? email,
    String? userName,
    String? role,
  }) async {
    await _service.login(
      userId: userId,
      email: email,
      userName: userName,
      role: role,
    );
    _isLogin = true;
    _userId = userId;
    _userEmail = email;
    _userName = userName;
    _userRole = role;
    notifyListeners();
  }

  /// Logout user and clear persisted state
  Future<void> logout() async {
    await _service.logout();
    _isLogin = false;
    _userId = null;
    _userEmail = null;
    _userName = null;
    _userRole = null;
    notifyListeners();
  }

  /// Clear all preferences
  Future<void> clearAll() async {
    await _service.clearAll();
    _isLogin = false;
    _userId = null;
    _userEmail = null;
    _userName = null;
    _userRole = null;
    notifyListeners();
  }
}
