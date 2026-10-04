import 'package:flutter/material.dart';

import '../models/video_model.dart';

class VideoProvider extends ChangeNotifier {
  final List<VideoItem> _videos = [
    VideoItem(
      id: '1',
      userName: 'emre_live',
      handle: '@emre_live',
      profileImage:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=200&q=80',
      caption: 'Gün batımıyla birlikte canlı set 👀',
      music: 'Original Sound - Emre Live',
      location: 'İstanbul',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1516280440614-37939bbacd81?auto=format&fit=crop&w=900&q=80',
      likes: 25400,
      comments: 910,
      shares: 123,
      isVerified: true,
    ),
    VideoItem(
      id: '2',
      userName: 'nisa_88',
      handle: '@nisa_88',
      profileImage:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=200&q=80',
      caption: 'Kısa dans ve eğlence akışı ✨',
      music: 'Summer Vibes - Nisa',
      location: 'Ankara',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=900&q=80',
      likes: 18320,
      comments: 542,
      shares: 88,
    ),
    VideoItem(
      id: '3',
      userName: 'dilan.c',
      handle: '@dilan.c',
      profileImage:
          'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?auto=format&fit=crop&w=200&q=80',
      caption: 'Yeni konsept içerik hazır 🚀',
      music: 'Night City - Dilan',
      location: 'İzmir',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?auto=format&fit=crop&w=900&q=80',
      likes: 31540,
      comments: 1210,
      shares: 215,
      isVerified: true,
    ),
  ];

  List<VideoItem> get videos => _videos;

  Future<void> loadVideos() async {
    notifyListeners();
  }
}
