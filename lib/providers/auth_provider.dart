import 'package:flutter/material.dart';
import '../../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _currentUser;
  String? _token;
  bool _isLoading = false;
  String? _error;

  UserModel? get currentUser => _currentUser;
  String? get token => _token;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _token != null && _currentUser != null;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: API call to backend
      // final response = await apiService.login(email, password);
      // _token = response.token;
      // _currentUser = response.user;
      
      // Geçici mock veri
      await Future.delayed(const Duration(seconds: 2));
      _currentUser = UserModel(
        id: '1',
        username: 'testuser',
        email: email,
        profileImage: 'https://via.placeholder.com/150',
        language: 'tr',
        vipLevel: 0,
      );
      _token = 'mock_token_12345';
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(String username, String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: API call to backend
      await Future.delayed(const Duration(seconds: 2));
      _currentUser = UserModel(
        id: '1',
        username: username,
        email: email,
        profileImage: 'https://via.placeholder.com/150',
        language: 'tr',
        vipLevel: 0,
      );
      _token = 'mock_token_12345';
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    _token = null;
    _error = null;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
