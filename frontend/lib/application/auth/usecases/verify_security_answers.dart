import '../../../domain/auth/repositories/auth_repository.dart';

class VerifySecurityAnswersUseCase {
  final AuthRepository repository;

  VerifySecurityAnswersUseCase(this.repository);

  Future<bool> execute({
    required String username,
    required String answer1,
    required String answer2,
  }) {
    return repository.verifySecurityAnswers(
      username: username,
      answer1: answer1,
      answer2: answer2,
    );
  }
}
