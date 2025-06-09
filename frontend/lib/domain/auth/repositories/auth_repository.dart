abstract class AuthRepository {
  Future<void> login({
    required String username,
    required String password,
    required String role,
  });
}
