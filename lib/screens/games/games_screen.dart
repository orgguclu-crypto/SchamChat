import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final games = [
      {'name': 'Azal Farm', 'type': 'Wheel'},
      {'name': 'Jackpot', 'type': 'Slot'},
      {'name': 'Money Pot', 'type': 'Slot'},
      {'name': 'Gold of Olympus', 'type': 'Slot'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Games')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.95,
        ),
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.gold, width: 1.5),
            ),
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppColors.gold,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(Icons.videogame_asset, color: Colors.white, size: 36),
                ),
                const SizedBox(height: 12),
                Text(game['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 6),
                Text(game['type']!, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Play'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
