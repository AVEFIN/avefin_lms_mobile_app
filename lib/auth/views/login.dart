import 'package:avefin_lms_mobile_app/auth/services/auth_provider.dart';
import 'package:avefin_lms_mobile_app/auth/services/auth_repository.dart';
import 'package:avefin_lms_mobile_app/widgets_design_system/widget_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  Future<void> _handleLogin({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      final container = ProviderScope.containerOf(context, listen: false);

      final repo = container.read(authRepositoryProvider);
      final authNotifier = container.read(authProvider.notifier);

      final response = await repo.login(
        email: email,
        password: password,
        rememberMe: rememberMe,
      );

      await authNotifier.login(response);

      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    } catch (e) {
      debugPrint("Login error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WidgetTestView()); // your UI here
  }
}
