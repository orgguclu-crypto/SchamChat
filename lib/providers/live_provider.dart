import 'package:flutter/material.dart';

import '../models/video_model.dart';

class LiveProvider extends ChangeNotifier {
  final List<LiveRoom> _rooms = [
    const LiveRoom(
      id: 'l1',
      title: 'Gecenin En İyi Mixi',
      hostName: 'Mavi Fener',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=900&q=80',
      viewers: 18500,
      isHot: true,
    ),
    const LiveRoom(
      id: 'l2',
      title: 'Canlı Kahve Keyfi',
      hostName: 'Bora',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1529156069898-49953e39b3ac?auto=format&fit=crop&w=900&q=80',
      viewers: 9800,
    ),
    const LiveRoom(
      id: 'l3',
      title: 'Oyun + Sohbet',
      hostName: 'Zey',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&w=900&q=80',
      viewers: 7640,
    ),
  ];

  List<LiveRoom> get rooms => _rooms;

  void refresh() {
    notifyListeners();
  }
}
