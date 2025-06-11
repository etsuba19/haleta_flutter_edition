import 'package:dio/dio.dart';
import '../../../domain/reset_password/entities/reset_password.dart';

abstract class ResetPasswordRemoteDataSource {
  Future<bool> resetPassword(ResetPassword resetPassword);
  Future<bool> validateResetToken(String token);
  Future<String> generateResetToken(String username);
}

class ResetPasswordRemoteDataSourceImpl implements ResetPasswordRemoteDataSource {
  final Dio dio;
  final String baseUrl;

  ResetPasswordRemoteDataSourceImpl({
    required this.dio,
    this.baseUrl = 'http://localhost:3000/api',
  });

  @override
  Future<bool> resetPassword(ResetPassword resetPassword) async {
    try {
      final response = await dio.post(
        '$baseUrl/auth/reset-password',
        data: resetPassword.toJson(),
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Failed to reset password: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error occurred during password reset');
    }
  }

  @override
  Future<bool> validateResetToken(String token) async {
    try {
      final response = await dio.post(
        '$baseUrl/auth/validate-reset-token',
        data: {'token': token},
      );

      return response.statusCode == 200 && response.data['valid'] == true;
    } on DioException catch (e) {
      throw Exception('Failed to validate reset token: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error occurred during token validation');
    }
  }

  @override
  Future<String> generateResetToken(String username) async {
    try {
      final response = await dio.post(
        '$baseUrl/auth/generate-reset-token',
        data: {'username': username},
      );

      if (response.statusCode == 200 && response.data['token'] != null) {
        return response.data['token'];
      } else {
        throw Exception('Failed to generate reset token');
      }
    } on DioException catch (e) {
      throw Exception('Failed to generate reset token: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error occurred during token generation');
    }
  }
} 