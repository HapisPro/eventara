import 'package:eventara/data/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';

class SharedPreferenceProvider extends ChangeNotifier {
  final SharedPreferencesService _service;

  SharedPreferenceProvider(this._service);

  bool _isLogin = false;
  String? _userId;
  String? _userEmail;
  String? _userName;
  String? _userRole;

  bool get isLogin => _service.isLogin ?? _isLogin;

  String? get userId => _service.userId ?? _userId;

  String? get userEmail => _service.userEmail ?? _userEmail;

  String? get userName => _service.userName ?? _userName;

  String? get userRole => _service.userRole ?? _userRole;

  void init() {
    _isLogin = _service.isLogin ?? false;
    _userId = _service.userId;
    _userEmail = _service.userEmail;
    _userName = _service.userName;
    _userRole = _service.userRole;
    notifyListeners();
  }

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

  Future<void> logout() async {
    await _service.logout();
    _isLogin = false;
    _userId = null;
    _userEmail = null;
    _userName = null;
    _userRole = null;
    notifyListeners();
  }

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
