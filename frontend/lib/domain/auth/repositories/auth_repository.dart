import '../entities/security_questions.dart';
abstract class AuthRepository {
  Future<void> login({
    required String username,
    required String password,
    required String role,
  });

  Future<void> saveSecurityQuestions({
    required String username,
    required SecurityQuestions questions,
  });

  Future<bool> verifySecurityAnswers({
    required String username,
    required String answer1,
    required String answer2,
  });
}

abstract class UserRepository {
  Future<bool> doesUserExist(String username);
}
