import 'package:flutter/material.dart';
import '../../models/room_model.dart';

class RoomProvider extends ChangeNotifier {
  List<RoomModel> _rooms = [];
  RoomModel? _currentRoom;
  bool _isLoading = false;
  String? _error;

  List<RoomModel> get rooms => _rooms;
  RoomModel? get currentRoom => _currentRoom;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchRooms() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: API call
      await Future.delayed(const Duration(seconds: 1));
      _rooms = [
        RoomModel(
          id: '1',
          name: 'Müzik Odası',
          description: 'En yeni müzikleri dinleyelim',
          currentUsers: 5,
          maxUsers: 20,
          category: 'music',
          isLive: true,
        ),
        RoomModel(
          id: '2',
          name: 'Sohbet Odası',
          description: 'Arkadaşlarla sohbet edin',
          currentUsers: 12,
          maxUsers: 50,
          category: 'talk',
          isLive: true,
        ),
      ];
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> joinRoom(String roomId) async {
    try {
      // TODO: API call
      _currentRoom = _rooms.firstWhere((r) => r.id == roomId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> leaveRoom() async {
    _currentRoom = null;
    notifyListeners();
  }
}
