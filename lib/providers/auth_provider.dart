import 'package:eventara/data/services/auth_service.dart';
import 'package:eventara/data/state/auth_state.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  AuthState _state = AuthInitial();

  AuthState get state => _state;

  bool get isLoading => _state is AuthLoading;

  // Store user data for persist login
  Map<String, dynamic>? _userData;
  Map<String, dynamic>? get userData => _userData;

  Future<void> signIn(String email, String password) async {
    _state = AuthLoading();
    notifyListeners();

    try {
      final userData = await _authService.signIn(email, password);
      _userData = userData; // Store user data
      _state = AuthSuccess(userData['username'] ?? 'User');
    } catch (e) {
      _state = AuthError(e.toString().replaceFirst('Exception: ', ''));
    }

    notifyListeners();
  }

  Future<void> signUp(
    String name,
    String email,
    String password,
    String role,
  ) async {
    _state = AuthLoading();
    notifyListeners();

    try {
      await _authService.signUp(
        name: name,
        email: email,
        password: password,
        role: role,
      );
      _state = AuthSuccess(name);
    } catch (e) {
      _state = AuthError(e.toString().replaceFirst('Exception: ', ''));
    }

    notifyListeners();
  }

  Future<void> signOut() async {
    _state = AuthLoading();
    notifyListeners();

    try {
      await _authService.signOut();
      _userData = null; // Clear user data
      _state = AuthInitial(); // reset ke state awal
    } catch (e) {
      _state = AuthError("Gagal logout: $e");
    }

    notifyListeners();
  }

  void resetState() {
    _state = AuthInitial();
    notifyListeners();
  }
}
