import 'package:avefin_lms_mobile_app/auth/models/auth_user.dart';

class AuthState {
  final bool isAuthenticated;
  final User? user;

  const AuthState({required this.isAuthenticated, required this.user});

  factory AuthState.unauthenticated() =>
      const AuthState(isAuthenticated: false, user: null);

  factory AuthState.authenticated(User user) =>
      AuthState(isAuthenticated: true, user: user);
}
