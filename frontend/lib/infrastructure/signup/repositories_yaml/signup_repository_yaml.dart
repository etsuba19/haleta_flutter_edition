import 'package:dio/dio.dart';
import '../../../domain/signup/repositories/signup_repository.dart';
import '../../../domain/signup/entities/signup_entity.dart';

class SignupRepositoryImpl implements SignupRepository {
  final Dio dio;

  SignupRepositoryImpl(this.dio);

  @override
  Future<void> signup(SignupData data) async {
    final response = await dio.post(
      'https://yourapi.com/signup',
      data: {
        // 'email': data.email,
        'username': data.username,
        'password': data.password,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Signup failed');
    }
  }
}
