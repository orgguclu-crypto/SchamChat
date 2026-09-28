import 'package:flutter/material.dart';
import '../../models/game_model.dart';

class GameProvider extends ChangeNotifier {
  List<GameModel> _games = [];
  bool _isLoading = false;
  String? _error;
  double _balance = 1000.0;

  List<GameModel> get games => _games;
  bool get isLoading => _isLoading;
  String? get error => _error;
  double get balance => _balance;

  Future<void> fetchGames() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: API call
      await Future.delayed(const Duration(seconds: 1));
      _games = [
        GameModel(
          id: '1',
          name: 'Azal Farm',
          type: 'wheel',
          description: 'Şans çarkı mini oyunu',
          minBet: 1,
          maxBet: 1000,
        ),
        GameModel(
          id: '2',
          name: 'Jackpot',
          type: 'slot',
          description: 'Meyve simgeli slot makinesi',
          minBet: 5,
          maxBet: 500,
        ),
        GameModel(
          id: '3',
          name: 'Money Pot',
          type: 'slot',
          description: 'Doğu temalı altın oyunu',
          minBet: 10,
          maxBet: 2000,
        ),
      ];
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> playGame(String gameId, double bet) async {
    try {
      if (_balance >= bet) {
        _balance -= bet;
        notifyListeners();

        // Simulate game result
        await Future.delayed(const Duration(seconds: 2));
        
        bool isWin = DateTime.now().millisecond % 2 == 0;
        if (isWin) {
          _balance += bet * 2;
        }
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
