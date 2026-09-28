import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/room_provider.dart';
import '../../providers/moment_provider.dart';
import '../../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const RoomsTab(),
    const MomentsTab(),
    const GamesTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SchamChat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.black,
        selectedItemColor: AppColors.gold,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'Rooms'),
          BottomNavigationBarItem(icon: Icon(Icons.dynamic_feed), label: 'Moments'),
          BottomNavigationBarItem(icon: Icon(Icons.videogame_asset), label: 'Games'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Mine'),
        ],
      ),
    );
  }
}

class RoomsTab extends StatefulWidget {
  const RoomsTab({Key? key}) : super(key: key);

  @override
  State<RoomsTab> createState() => _RoomsTabState();
}

class _RoomsTabState extends State<RoomsTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RoomProvider>().fetchRooms();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomProvider>(
      builder: (context, roomProvider, _) {
        if (roomProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: roomProvider.rooms.length,
          itemBuilder: (context, index) {
            final room = roomProvider.rooms[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.gold, width: 1.5),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.gold,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.mic, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(room.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 4),
                        Text(room.description, style: const TextStyle(color: Colors.grey)),
                        const SizedBox(height: 6),
                        Text('${room.currentUsers}/${room.maxUsers} online'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => roomProvider.joinRoom(room.id),
                    child: const Text('Join'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class MomentsTab extends StatefulWidget {
  const MomentsTab({Key? key}) : super(key: key);

  @override
  State<MomentsTab> createState() => _MomentsTabState();
}

class _MomentsTabState extends State<MomentsTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MomentProvider>().fetchMoments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MomentProvider>(
      builder: (context, momentProvider, _) {
        if (momentProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: momentProvider.moments.length,
          itemBuilder: (context, index) {
            final moment = momentProvider.moments[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 22,
                        child: Icon(Icons.person),
                      ),
                      const SizedBox(width: 10),
                      Text(moment.author),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(moment.content),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => context.read<MomentProvider>().likeMoment(moment.id),
                        icon: const Icon(Icons.favorite_border),
                      ),
                      Text('${moment.likes}'),
                      const SizedBox(width: 18),
                      const Icon(Icons.comment_outlined),
                      const SizedBox(width: 6),
                      Text('${moment.comments}'),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class GamesTab extends StatefulWidget {
  const GamesTab({Key? key}) : super(key: key);

  @override
  State<GamesTab> createState() => _GamesTabState();
}

class _GamesTabState extends State<GamesTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameProvider>().fetchGames();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, _) {
        if (gameProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: gameProvider.games.length,
          itemBuilder: (context, index) {
            final game = gameProvider.games[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.gold, width: 1.5),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.gold,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.videogame_asset, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(game.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 4),
                        Text(game.description, style: const TextStyle(color: Colors.grey)),
                        const SizedBox(height: 4),
                        Text('Min Bet: ${game.minBet} / Max Bet: ${game.maxBet}'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => gameProvider.playGame(game.id, game.minBet),
                    child: const Text('Play'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            child: Icon(Icons.person, size: 50),
          ),
          const SizedBox(height: 16),
          const Text('Test User', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('VIP Level: 2', style: TextStyle(color: AppColors.gold)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _InfoCard(title: 'Followers', value: '1240'),
              _InfoCard(title: 'Following', value: '540'),
              _InfoCard(title: 'Coins', value: '1500'),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: const Text('Go to Profile'),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;

  const _InfoCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ],
      ),
    );
  }
}
