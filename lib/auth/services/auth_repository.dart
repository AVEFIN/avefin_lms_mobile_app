import 'package:avefin_lms_mobile_app/auth/models/auth_response.dart';
import 'package:avefin_lms_mobile_app/utils/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.read(dioProvider);
  return AuthRepository(dio);
});

class AuthRepository {
  final Dio dio;

  AuthRepository(this.dio);

  Future<AuthResponse> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    final response = await dio.post(
      "api/auth/login/",
      data: {"email": email, "password": password},
    );

    return AuthResponse.fromJson(response.data);
  }
}
