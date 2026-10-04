import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'screens/home_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/video_provider.dart';
import 'providers/live_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('tr')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: const SchamChatApp(),
    ),
  );
}

class SchamChatApp extends StatelessWidget {
  const SchamChatApp({Key? key}) : super(key: key);

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
            ChangeNotifierProvider(create: (_) => VideoProvider()),
            ChangeNotifierProvider(create: (_) => LiveProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'SchamChat',
            theme: ThemeData(
              primaryColor: const Color(0xFF000000),
              scaffoldBackgroundColor: const Color(0xFF000000),
              useMaterial3: true,
              brightness: Brightness.dark,
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
