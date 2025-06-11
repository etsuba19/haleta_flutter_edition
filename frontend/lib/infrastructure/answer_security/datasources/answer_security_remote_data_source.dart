import 'package:dio/dio.dart';
import '../../../domain/answer_security/entities/answer_security.dart';

abstract class AnswerSecurityRemoteDataSource {
  Future<AnswerSecurity> verifySecurityAnswer(String username, String answer);
  Future<String> getSecurityQuestion(String username);
  Future<bool> updateSecurityQuestion(String username, String question, String answer);
}

class AnswerSecurityRemoteDataSourceImpl implements AnswerSecurityRemoteDataSource {
  final Dio dio;
  final String baseUrl;

  AnswerSecurityRemoteDataSourceImpl({
    required this.dio,
    this.baseUrl = 'http://localhost:3000/api',
  });

  @override
  Future<AnswerSecurity> verifySecurityAnswer(String username, String answer) async {
    try {
      final response = await dio.post(
        '$baseUrl/auth/verify-security-answer',
        data: {
          'username': username,
          'answer': answer,
        },
      );

      if (response.statusCode == 200) {
        return AnswerSecurity.fromJson(response.data);
      } else {
        throw Exception('Failed to verify security answer');
      }
    } on DioException catch (e) {
      throw Exception('Failed to verify security answer: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error occurred during answer verification');
    }
  }

  @override
  Future<String> getSecurityQuestion(String username) async {
    try {
      final response = await dio.get(
        '$baseUrl/auth/security-question/$username',
      );

      if (response.statusCode == 200 && response.data['question'] != null) {
        return response.data['question'];
      } else {
        throw Exception('Security question not found');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('User not found');
      }
      throw Exception('Failed to get security question: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error occurred while fetching security question');
    }
  }

  @override
  Future<bool> updateSecurityQuestion(String username, String question, String answer) async {
    try {
      final response = await dio.put(
        '$baseUrl/auth/security-question',
        data: {
          'username': username,
          'question': question,
          'answer': answer,
        },
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Failed to update security question: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error occurred during security question update');
    }
  }
} 