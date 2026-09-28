import 'package:flutter/material.dart';
import '../../models/moment_model.dart';

class MomentProvider extends ChangeNotifier {
  List<MomentModel> _moments = [];
  bool _isLoading = false;
  String? _error;

  List<MomentModel> get moments => _moments;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchMoments() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: API call
      await Future.delayed(const Duration(seconds: 1));
      _moments = [
        MomentModel(
          id: '1',
          author: 'user1',
          content: 'Harika bir gün geçiriyorum!',
          likes: 45,
          comments: 12,
          createdAt: DateTime.now(),
        ),
      ];
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createMoment(String content, {String? imageUrl}) async {
    try {
      // TODO: API call
      _moments.insert(
        0,
        MomentModel(
          id: DateTime.now().toString(),
          author: 'current_user',
          content: content,
          likes: 0,
          comments: 0,
          createdAt: DateTime.now(),
        ),
      );
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> likeMoment(String momentId) async {
    try {
      final index = _moments.indexWhere((m) => m.id == momentId);
      if (index >= 0) {
        _moments[index] = _moments[index].copyWith(
          likes: _moments[index].likes + 1,
        );
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
