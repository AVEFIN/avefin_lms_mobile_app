import 'package:avefin_lms_mobile_app/auth/models/auth_user.dart';

class AuthResponse {
  final User user;
  final bool? rememberMe;

  const AuthResponse({required this.user, this.rememberMe});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: User.fromJson(json['user']),
      rememberMe: json['rememberMe'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'user': user.toJson(), 'rememberMe': rememberMe};
  }
}
