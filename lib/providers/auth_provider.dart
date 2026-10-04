import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final String _userName = 'selin_48';
  final String _fullName = 'Selin Demir';
  final String _bio = '🎧 Müzik, eğlence ve canlı yayın';
  final String _avatarUrl =
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=400&q=80';

  String get userName => _userName;
  String get fullName => _fullName;
  String get bio => _bio;
  String get avatarUrl => _avatarUrl;

  int _followers = 18200;
  int _following = 350;
  int _likes = 480000;

  int get followers => _followers;
  int get following => _following;
  int get likes => _likes;

  void refreshProfile() {
    notifyListeners();
  }
}
