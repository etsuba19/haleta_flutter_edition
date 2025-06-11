import 'package:dio/dio.dart';
import '../../../domain/forgot_password/entities/forgot_password.dart';

abstract class ForgotPasswordRemoteDataSource {
  Future<ForgotPassword> sendPasswordResetLink(String username);
  Future<bool> validateResetLink(String token);
  Future<ForgotPassword> getUserByUsername(String username);
}

class ForgotPasswordRemoteDataSourceImpl implements ForgotPasswordRemoteDataSource {
  final Dio dio;
  final String baseUrl;

  ForgotPasswordRemoteDataSourceImpl({
    required this.dio,
    this.baseUrl = 'http://localhost:3000/api',
  });

  @override
  Future<ForgotPassword> sendPasswordResetLink(String username) async {
    try {
      final response = await dio.post(
        '$baseUrl/auth/forgot-password',
        data: {'username': username},
      );

      if (response.statusCode == 200) {
        return ForgotPassword.fromJson(response.data);
      } else {
        throw Exception('Failed to send password reset link');
      }
    } on DioException catch (e) {
      throw Exception('Failed to send password reset link: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error occurred while sending reset link');
    }
  }

  @override
  Future<bool> validateResetLink(String token) async {
    try {
      final response = await dio.post(
        '$baseUrl/auth/validate-reset-link',
        data: {'token': token},
      );

      return response.statusCode == 200 && response.data['valid'] == true;
    } on DioException catch (e) {
      throw Exception('Failed to validate reset link: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error occurred during link validation');
    }
  }

  @override
  Future<ForgotPassword> getUserByUsername(String username) async {
    try {
      final response = await dio.get(
        '$baseUrl/users/$username',
      );

      if (response.statusCode == 200) {
        return ForgotPassword.fromJson(response.data);
      } else {
        throw Exception('User not found');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('User not found');
      }
      throw Exception('Failed to get user: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error occurred while fetching user');
    }
  }
} 