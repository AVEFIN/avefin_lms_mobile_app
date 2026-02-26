import 'package:avefin_lms_mobile_app/auth/services/auth_provider.dart';
import 'package:avefin_lms_mobile_app/auth/views/login.dart';
import 'package:avefin_lms_mobile_app/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authProvider);

    return authAsync.when(
      loading:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (_, __) => const Scaffold(body: Center(child: Text("Error"))),
      data: (state) {
        if (state.isAuthenticated) {
          return const HomeView();
        } else {
          return const LogInScreen();
        }
      },
    );
  }
}
