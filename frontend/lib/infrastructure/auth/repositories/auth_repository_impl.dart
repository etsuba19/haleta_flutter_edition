import '../../../domain/auth/repositories/auth_repository.dart';
// import '../../../domain/user/repositories/user_repository.dart';

abstract class AuthRepositoryImpl implements AuthRepository {
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




class UserRepositoryImpl implements UserRepository {
  final List<String> _usernames = ['demo', 'admin', 'test'];

  @override
  Future<bool> doesUserExist(String username) async {
    await Future.delayed(Duration(milliseconds: 500)); // simulate latency
    return _usernames.contains(username);
  }
}
