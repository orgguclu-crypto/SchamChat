import 'package:flutter/material.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/rooms/rooms_screen.dart';
import '../screens/moments/moments_screen.dart';
import '../screens/games/games_screen.dart';
import '../screens/profile/profile_screen.dart';

class AppRouter {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const HomeScreen(),
    '/login': (context) => const LoginScreen(),
    '/register': (context) => const RegisterScreen(),
    '/home': (context) => const HomeScreen(),
    '/rooms': (context) => const RoomsScreen(),
    '/moments': (context) => const MomentsScreen(),
    '/games': (context) => const GamesScreen(),
    '/profile': (context) => const ProfileScreen(),
  };
}
