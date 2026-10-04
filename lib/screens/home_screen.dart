import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/video_model.dart';
import '../providers/auth_provider.dart';
import '../providers/game_provider.dart';
import '../providers/live_provider.dart';
import '../providers/video_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const VideoFeedScreen(),
      const DiscoverScreen(),
      const GamesScreen(),
      const FriendsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: screens),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Yeni içerik oluşturuluyor...')),
          );
        },
        backgroundColor: const Color(0xFFFF2D55),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.black,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Ana Sayfa'),
          NavigationDestination(icon: Icon(Icons.search_outlined), selectedIcon: Icon(Icons.search), label: 'Keşfet'),
          NavigationDestination(icon: Icon(Icons.casino_outlined), selectedIcon: Icon(Icons.casino), label: 'Gazino'),
          NavigationDestination(icon: Icon(Icons.people_alt_outlined), selectedIcon: Icon(Icons.people_alt), label: 'Arkadaşlar'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

class VideoFeedScreen extends StatelessWidget {
  const VideoFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final videos = context.watch<VideoProvider>().videos;

    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return VideoTile(video: video);
      },
    );
  }
}

class VideoTile extends StatelessWidget {
  final VideoItem video;

  const VideoTile({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: video.thumbnailUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => const ColoredBox(color: Color(0xFF1A1A1A)),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withOpacity(0.05), Colors.black.withOpacity(0.82)],
            ),
          ),
        ),
        Positioned(
          top: 44,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'SchamChat',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
              ),
              Row(
                children: const [
                  Icon(Icons.live_tv, color: Colors.red, size: 18),
                  SizedBox(width: 8),
                  Text('Canlı', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 16,
          right: 86,
          bottom: 28,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: CachedNetworkImageProvider(video.profileImage),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    video.userName,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  if (video.isVerified) ...[
                    const SizedBox(width: 6),
                    const Icon(Icons.verified, color: Colors.blue, size: 16),
                  ],
                ],
              ),
              const SizedBox(height: 10),
              Text(
                video.caption,
                style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.music_note, size: 16, color: Colors.white),
                  const SizedBox(width: 6),
                  Text(video.music, style: const TextStyle(fontSize: 13, color: Colors.white70)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.white70),
                  const SizedBox(width: 6),
                  Text(video.location, style: const TextStyle(fontSize: 12, color: Colors.white70)),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right: 12,
          bottom: 54,
          child: Column(
            children: [
              _ActionButton(icon: Icons.favorite, value: video.likes, color: Colors.white),
              const SizedBox(height: 24),
              _ActionButton(icon: Icons.chat_bubble_outline, value: video.comments, color: Colors.white),
              const SizedBox(height: 24),
              _ActionButton(icon: Icons.share, value: video.shares, color: Colors.white),
              const SizedBox(height: 24),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white24),
                  color: Colors.black26,
                ),
                child: const Icon(Icons.more_vert, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final int value;
  final Color color;

  const _ActionButton({required this.icon, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.25),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white12),
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 6),
        Text(
          _compactValue(value),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
        ),
      ],
    );
  }

  String _compactValue(int value) {
    if (value >= 10000) return '${(value / 10000).toStringAsFixed(1)}k';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(1)}k';
    return value.toString();
  }
}

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final liveRooms = context.watch<LiveProvider>().rooms;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Keşfet', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Colors.white)),
            const SizedBox(height: 18),
            SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _TagChip(label: '#Trend', selected: true),
                  _TagChip(label: '#Müzik'),
                  _TagChip(label: '#Yemek'),
                  _TagChip(label: '#Güzellik'),
                  _TagChip(label: '#Canlı'),
                ],
              ),
            ),
            const SizedBox(height: 22),
            const Text('Canlı odalar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: liveRooms.length,
                itemBuilder: (context, index) {
                  final room = liveRooms[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(room.thumbnailUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              if (room.isHot)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'HOT',
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white),
                                  ),
                                ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.remove_red_eye, size: 12, color: Colors.white),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${room.viewers ~/ 1000}k',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            room.title,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                          Text(room.hostName, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;
  final bool selected;

  const _TagChip({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFFF2D55) : const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
    );
  }
}

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final games = context.watch<GameProvider>().games;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Gazino', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Colors.white)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('2,480 Coins', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 18),
            const Text('Popüler Oyunlar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) {
                  final game = games[index];
                  final color = Color(int.parse(game.accent.replaceFirst('#', '0xFF')));

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [color.withOpacity(0.9), Colors.black],
                      ),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Center(child: Text(game.icon, style: const TextStyle(fontSize: 28))),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(game.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 22)),
                              const SizedBox(height: 4),
                              Text(game.subtitle, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                              const SizedBox(height: 8),
                              Text(
                                'Jackpot: ${game.jackpot.toStringAsFixed(0)} Coin',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text('Oyna'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Arkadaşlar', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Colors.white)),
            const SizedBox(height: 18),
            Expanded(
              child: ListView(
                children: const [
                  _FriendRow(name: 'Elif', status: 'Canlı yayında', color: Colors.green),
                  _FriendRow(name: 'Kemal', status: 'Yeni video paylaştı', color: Colors.orange),
                  _FriendRow(name: 'Seda', status: 'Senin videonu beğendi', color: Colors.purple),
                  _FriendRow(name: 'Mert', status: 'Birlikte oynayalım', color: Colors.blue),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FriendRow extends StatelessWidget {
  final String name;
  final String status;
  final Color color;

  const _FriendRow({required this.name, required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 26,
            child: Text(name.substring(0, 1), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                const SizedBox(height: 4),
                Text(status, style: const TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          const Icon(Icons.chat_bubble_outline, color: Colors.white70),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: const [
                Icon(Icons.arrow_back_ios_new, color: Colors.white),
                Spacer(),
                Icon(Icons.more_vert, color: Colors.white),
              ],
            ),
            const SizedBox(height: 18),
            CircleAvatar(
              radius: 52,
              backgroundImage: CachedNetworkImageProvider(user.avatarUrl),
            ),
            const SizedBox(height: 18),
            Text(user.fullName, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white)),
            Text('@${user.userName}', style: const TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 12),
            Text(user.bio, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500)),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatTile(label: 'Takipçi', value: '${user.followers}'),
                _StatTile(label: 'Takip', value: '${user.following}'),
                _StatTile(label: 'Beğeni', value: '${user.likes}'),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF2D55),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Profili Düzenle'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;

  const _StatTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 24)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}
