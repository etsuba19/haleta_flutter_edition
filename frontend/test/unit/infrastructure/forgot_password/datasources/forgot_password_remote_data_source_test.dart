import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:frontend/domain/forgot_password/entities/forgot_password.dart';
import 'package:frontend/infrastructure/forgot_password/datasources/forgot_password_remote_data_source.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late ForgotPasswordRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = ForgotPasswordRemoteDataSourceImpl(dio: mockDio);
    
    // Register fallback values
    registerFallbackValue(RequestOptions(path: ''));
  });

  group('ForgotPasswordRemoteDataSource', () {
    const testUsername = 'testuser';
    const testToken = 'reset-token-123';
    final testForgotPassword = ForgotPassword(
      username: testUsername,
      email: 'test@example.com',
      resetToken: testToken,
      requestTime: DateTime.parse('2023-12-01T10:00:00Z'),
      isTokenValid: true,
    );

    group('sendPasswordResetLink', () {
      test('should return ForgotPassword when reset link is sent successfully', () async {
        // arrange
        when(() => mockDio.post(
              any(),
              data: any(named: 'data'),
            )).thenAnswer((_) async => Response(
                  statusCode: 200,
                  data: testForgotPassword.toJson(),
                  requestOptions: RequestOptions(path: ''),
                ));

        // act
        final result = await dataSource.sendPasswordResetLink(testUsername);

        // assert
        expect(result.username, testForgotPassword.username);
        expect(result.email, testForgotPassword.email);
      });

      test('should throw exception when request fails', () async {
        // arrange
        when(() => mockDio.post(
              any(),
              data: any(named: 'data'),
            )).thenThrow(DioException(
              requestOptions: RequestOptions(path: ''),
              message: 'Network error',
            ));

        // act & assert
        expect(
          () => dataSource.sendPasswordResetLink(testUsername),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('validateResetLink', () {
      test('should return true when token is valid', () async {
        // arrange
        when(() => mockDio.post(
              any(),
              data: any(named: 'data'),
            )).thenAnswer((_) async => Response(
                  statusCode: 200,
                  data: {'valid': true},
                  requestOptions: RequestOptions(path: ''),
                ));

        // act
        final result = await dataSource.validateResetLink(testToken);

        // assert
        expect(result, true);
      });

      test('should return false when token is invalid', () async {
        // arrange
        when(() => mockDio.post(
              any(),
              data: any(named: 'data'),
            )).thenAnswer((_) async => Response(
                  statusCode: 200,
                  data: {'valid': false},
                  requestOptions: RequestOptions(path: ''),
                ));

        // act
        final result = await dataSource.validateResetLink(testToken);

        // assert
        expect(result, false);
      });

      test('should throw exception when request fails', () async {
        // arrange
        when(() => mockDio.post(
              any(),
              data: any(named: 'data'),
            )).thenThrow(DioException(
              requestOptions: RequestOptions(path: ''),
              message: 'Network error',
            ));

        // act & assert
        expect(
          () => dataSource.validateResetLink(testToken),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('getUserByUsername', () {
      test('should return ForgotPassword when user is found', () async {
        // arrange
        when(() => mockDio.get(any())).thenAnswer((_) async => Response(
              statusCode: 200,
              data: testForgotPassword.toJson(),
              requestOptions: RequestOptions(path: ''),
            ));

        // act
        final result = await dataSource.getUserByUsername(testUsername);

        // assert
        expect(result.username, testForgotPassword.username);
        expect(result.email, testForgotPassword.email);
      });

      test('should throw exception when user is not found', () async {
        // arrange
        when(() => mockDio.get(any())).thenThrow(DioException(
              requestOptions: RequestOptions(path: ''),
              response: Response(statusCode: 404, requestOptions: RequestOptions(path: '')),
            ));

        // act & assert
        expect(
          () => dataSource.getUserByUsername(testUsername),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
} 