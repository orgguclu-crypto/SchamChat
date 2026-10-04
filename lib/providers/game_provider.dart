import 'package:flutter/material.dart';

import '../models/video_model.dart';

class GameProvider extends ChangeNotifier {
  final List<CasinoGame> _games = const [
    CasinoGame(
      id: 'slot',
      title: 'Lucky Spin',
      subtitle: 'Kazanan çizgileri yakala',
      accent: '#FFB703',
      jackpot: 1840.0,
      icon: '🎰',
    ),
    CasinoGame(
      id: 'roulette',
      title: 'Golden Wheel',
      subtitle: 'Şansın dönmeye başlasın',
      accent: '#8E44AD',
      jackpot: 960.0,
      icon: '🎡',
    ),
    CasinoGame(
      id: 'crash',
      title: 'Coin Rush',
      subtitle: 'Kârı yükselt ve çek',
      accent: '#22C55E',
      jackpot: 2100.0,
      icon: '🚀',
    ),
    CasinoGame(
      id: 'vip',
      title: 'High Roller',
      subtitle: 'VIP masa ve bonus',
      accent: '#F43F5E',
      jackpot: 4200.0,
      icon: '💎',
    ),
  ];

  List<CasinoGame> get games => _games;
}
