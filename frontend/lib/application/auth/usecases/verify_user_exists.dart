import '../../../domain/auth/repositories/auth_repository.dart';

class CheckUsernameExistsUseCase {
  final UserRepository repository;

  CheckUsernameExistsUseCase(this.repository);

  Future<bool> call(String username) {
    return repository.doesUserExist(username);
  }
}
