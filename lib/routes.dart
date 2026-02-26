import 'package:avefin_lms_mobile_app/auth/services/auth_provider.dart';
import 'package:avefin_lms_mobile_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void guardedPush(String route, WidgetRef ref) {
  final auth = ref.read(authProvider);

  auth.whenData((state) {
    if (state.isAuthenticated) {
      navigatorKey.currentState?.pushNamed(route);
    } else {
      navigatorKey.currentState?.pushNamed(AppRoutes.login);
    }
  });
}

class AppRoutes {
  static const home = '';
  static const login = 'login';
  static const register = 'register';
  static const verifyEmail = 'verify-email';
  static const resetPassword = 'reset-password';
}
