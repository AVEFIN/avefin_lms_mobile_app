import 'dart:convert';

import 'package:avefin_lms_mobile_app/auth/models/auth_response.dart';
import 'package:avefin_lms_mobile_app/auth/models/auth_state_model.dart';
import 'package:avefin_lms_mobile_app/auth/models/auth_user.dart';
import 'package:avefin_lms_mobile_app/utils/secure_storage_provider.dart';
import 'package:avefin_lms_mobile_app/environment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final authProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends AsyncNotifier<AuthState> {
  static const _authTimeKey = "auth.jwt.time";
  static const _sessionTimeKey = "auth.session.time";
  static const _userKey = "auth.user";

  late final FlutterSecureStorage _storage;

  @override
  Future<AuthState> build() async {
    _storage = ref.read(secureStorageProvider);

    final authTime = await _storage.read(key: _authTimeKey);
    final sessionTime = await _storage.read(key: _sessionTimeKey);
    final userJson = await _storage.read(key: _userKey);

    if (_isSessionExpired(sessionTime) || userJson == null) {
      await logout();
      return AuthState.unauthenticated();
    }

    final user = User.fromJson(jsonDecode(userJson));
    return AuthState.authenticated(user);
  }

  Future<void> login(AuthResponse auth) async {
    final now = DateTime.now().toIso8601String();

    await _storage.write(key: _sessionTimeKey, value: now);
    await _storage.write(key: _authTimeKey, value: now);
    await _storage.write(key: _userKey, value: jsonEncode(auth.user.toJson()));

    state = AsyncData(AuthState.authenticated(auth.user));
  }

  Future<void> logout() async {
    await _storage.delete(key: _sessionTimeKey);
    await _storage.delete(key: _authTimeKey);
    await _storage.delete(key: _userKey);

    // Optionally hit backend logout endpoint here

    state = AsyncData(AuthState.unauthenticated());
  }

  bool _isSessionExpired(String? storedTime) {
    if (storedTime == null) return true;

    final stored = DateTime.tryParse(storedTime);
    if (stored == null) return true;

    final diff = DateTime.now().difference(stored).inDays;
    return diff >= EnvironmentConfig.sessionExpiration;
  }
}
