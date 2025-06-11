import '../../../domain/auth/repositories/auth_repository.dart';
import '../../../domain/auth/entities/security_questions.dart';
// import '../../../domain/user/repositories/user_repository.dart';

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
  
  @override
  Future<void> saveSecurityQuestions({
    required String username,
    required SecurityQuestions questions,
  }) async {
    // TODO: Implement saving security questions
    await Future.delayed(Duration(milliseconds: 500));
  }

  @override
  Future<Map<String, String>> getSecurityQuestions(String username) async {
    // Mock implementation
    await Future.delayed(Duration(milliseconds: 500));
    return {
      'ምሕላ: የልጅነት ቋሊ ሰፈርዎ ማን ነበር?': '',
      'ምሕላ: የመጀመሪያ ትምህርት ቤት ማን ነበር?': '',
    };
  }

  @override
  Future<bool> verifySecurityAnswers({
    required String username,
    required Map<String, String> providedAnswers,
  }) async {
    // Mock implementation
    await Future.delayed(Duration(milliseconds: 500));
    return true; // In a real app, verify against stored answers
  }
  
  @override
  Future<bool> resetPassword({
    required String username,
    required String newPassword,
  }) async {
    try {
      // TODO: Implement actual API call to reset password
      await Future.delayed(Duration(milliseconds: 800));
      
      // Basic validation - password should be at least 6 characters
      if (newPassword.length < 6) {
        return false;
      }
      
      print('Password reset for user: $username');
      return true;
    } catch (e) {
      print('Error resetting password: $e');
      return false;
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
