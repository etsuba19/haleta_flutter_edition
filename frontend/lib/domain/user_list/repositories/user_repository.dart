import '../entities/user.dart';

abstract class UserRepository {
  Future<List<User>> fetchUsers();
  Future<void> removeUser(String id);
}
