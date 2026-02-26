import 'package:avefin_lms_mobile_app/auth/auth_gate.dart';
import 'package:avefin_lms_mobile_app/auth/views/login.dart';
import 'package:avefin_lms_mobile_app/home/home.dart';
import 'package:avefin_lms_mobile_app/routes.dart';
import 'package:avefin_lms_mobile_app/theme/dark_theme.dart';
import 'package:avefin_lms_mobile_app/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light, //todo cambiar a system despues
      home: const AuthGate(),
      routes: {
        AppRoutes.home: (_) => const HomeView(),
        AppRoutes.login: (_) => const LogInScreen(),
      },
    );
  }
}
