import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/localization.dart';
import 'config/router.dart';
import 'theme/app_theme.dart';
import 'providers/auth_provider.dart';
import 'providers/room_provider.dart';
import 'providers/moment_provider.dart';
import 'providers/wallet_provider.dart';
import 'providers/game_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  
  runApp(
    EasyLocalization(
      supportedLocales: LocalizationConfig.supportedLocales,
      path: 'assets/translations',
      fallbackLocale: const Locale('tr'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => RoomProvider()),
            ChangeNotifierProvider(create: (_) => MomentProvider()),
            ChangeNotifierProvider(create: (_) => WalletProvider()),
            ChangeNotifierProvider(create: (_) => GameProvider()),
          ],
          child: MaterialApp(
            title: 'SchamChat',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.light,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: child,
            routes: AppRouter.routes,
          ),
        );
      },
      child: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 120, height: 120),
            SizedBox(height: 20.h),
            Text(
              'SchamChat',
              style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50.h),
            Consumer<AuthProvider>(
              builder: (context, authProvider, _) {
                Future.delayed(const Duration(seconds: 2), () {
                  if (authProvider.isLoggedIn) {
                    Navigator.of(context).pushReplacementNamed('/home');
                  } else {
                    Navigator.of(context).pushReplacementNamed('/login');
                  }
                });
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
