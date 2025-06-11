import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/domain/signup/entities/signup_entity.dart';
import 'package:frontend/domain/signup/repositories/signup_repository.dart';
import 'package:frontend/infrastructure/signup/repositories_yaml/signup_repository_yaml.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late SignupRepositoryImpl repository;

  setUp(() {
    mockDio = MockDio();
    repository = SignupRepositoryImpl(mockDio);
  });

  final testSignupData = SignupData(
    username: 'testuser',
    password: 'password123',
    // email: 'test@example.com', // Uncomment if you add email
  );

  test('signup success when statusCode is 200', () async {
    when(() => mockDio.post(
      any(),
      data: any(named: 'data'),
    )).thenAnswer((_) async => Response(
      requestOptions: RequestOptions(path: ''),
      statusCode: 200,
    ));

    expect(repository.signup(testSignupData), completes);

    verify(() => mockDio.post(
      'https://yourapi.com/signup',
      data: {
        'username': testSignupData.username,
        'password': testSignupData.password,
      },
    )).called(1);
  });

  test('throws exception when statusCode is not 200', () async {
    when(() => mockDio.post(
      any(),
      data: any(named: 'data'),
    )).thenAnswer((_) async => Response(
      requestOptions: RequestOptions(path: ''),
      statusCode: 400,
    ));

    expect(() => repository.signup(testSignupData), throwsException);
  });
}
