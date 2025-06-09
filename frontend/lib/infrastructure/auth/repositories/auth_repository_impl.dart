import '../../../domain/auth/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> login({
    required String username,
    required String password,
    required String role,
  }) async {
    // TODO: Call your API or data source
    await Future.delayed(Duration(seconds: 1)); // fake delay
    if (username.isEmpty || password.isEmpty) {
      throw Exception("Missing credentials");
    }
  }
}
