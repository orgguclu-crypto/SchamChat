import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'screens/home_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/game_provider.dart';
import 'providers/video_provider.dart';
import 'providers/live_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('tr')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const SchamChatApp(),
    ),
  );
}

class SchamChatApp extends StatelessWidget {
  const SchamChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => GameProvider()),
            ChangeNotifierProvider(create: (_) => VideoProvider()),
            ChangeNotifierProvider(create: (_) => LiveProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'SchamChat',
            theme: ThemeData(
              primaryColor: const Color(0xFFFF2D55),
              scaffoldBackgroundColor: Colors.black,
              brightness: Brightness.dark,
              useMaterial3: true,
              fontFamily: 'Poppins',
            ),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: const HomeScreen(),
          ),
        );
      },
    );
  }
}
