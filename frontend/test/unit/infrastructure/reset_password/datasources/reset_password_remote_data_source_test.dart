import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:frontend/domain/reset_password/entities/reset_password.dart';
import 'package:frontend/infrastructure/reset_password/datasources/reset_password_remote_data_source.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late ResetPasswordRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = ResetPasswordRemoteDataSourceImpl(dio: mockDio);
  });

  group('ResetPasswordRemoteDataSource', () {
    const testResetPassword = ResetPassword(
      username: 'testuser',
      newPassword: 'newPassword123',
      confirmPassword: 'newPassword123',
      token: 'reset-token-123',
    );

    group('resetPassword', () {
      test('should return true when password reset is successful', () async {
        // arrange
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer((_) async => Response(
                  statusCode: 200,
                  requestOptions: RequestOptions(path: ''),
                ));

        // act
        final result = await dataSource.resetPassword(testResetPassword);

        // assert
        expect(result, true);
        verify(() => mockDio.post(
              'http://localhost:3000/api/auth/reset-password',
              data: testResetPassword.toJson(),
            ));
      });

      test('should throw exception when request fails', () async {
        // arrange
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenThrow(DioException(
              requestOptions: RequestOptions(path: ''),
              message: 'Network error',
            ));

        // act & assert
        expect(
          () => dataSource.resetPassword(testResetPassword),
          throwsA(isA<Exception>()),
        );
      });

      test('should throw exception when status code is not 200', () async {
        // arrange
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer((_) async => Response(
                  statusCode: 400,
                  requestOptions: RequestOptions(path: ''),
                ));

        // act
        final result = await dataSource.resetPassword(testResetPassword);

        // assert
        expect(result, false);
      });
    });

    group('validateResetToken', () {
      const testToken = 'test-token-123';

      test('should return true when token is valid', () async {
        // arrange
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer((_) async => Response(
                  statusCode: 200,
                  data: {'valid': true},
                  requestOptions: RequestOptions(path: ''),
                ));

        // act
        final result = await dataSource.validateResetToken(testToken);

        // assert
        expect(result, true);
        verify(() => mockDio.post(
              'http://localhost:3000/api/auth/validate-reset-token',
              data: {'token': testToken},
            ));
      });

      test('should return false when token is invalid', () async {
        // arrange
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer((_) async => Response(
                  statusCode: 200,
                  data: {'valid': false},
                  requestOptions: RequestOptions(path: ''),
                ));

        // act
        final result = await dataSource.validateResetToken(testToken);

        // assert
        expect(result, false);
      });

      test('should throw exception when request fails', () async {
        // arrange
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenThrow(DioException(
              requestOptions: RequestOptions(path: ''),
              message: 'Network error',
            ));

        // act & assert
        expect(
          () => dataSource.validateResetToken(testToken),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('generateResetToken', () {
      const testUsername = 'testuser';
      const testToken = 'generated-token-123';

      test('should return token when generation is successful', () async {
        // arrange
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer((_) async => Response(
                  statusCode: 200,
                  data: {'token': testToken},
                  requestOptions: RequestOptions(path: ''),
                ));

        // act
        final result = await dataSource.generateResetToken(testUsername);

        // assert
        expect(result, testToken);
        verify(() => mockDio.post(
              'http://localhost:3000/api/auth/generate-reset-token',
              data: {'username': testUsername},
            ));
      });

      test('should throw exception when token is not returned', () async {
        // arrange
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer((_) async => Response(
                  statusCode: 200,
                  data: {},
                  requestOptions: RequestOptions(path: ''),
                ));

        // act & assert
        expect(
          () => dataSource.generateResetToken(testUsername),
          throwsA(isA<Exception>()),
        );
      });

      test('should throw exception when request fails', () async {
        // arrange
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenThrow(DioException(
              requestOptions: RequestOptions(path: ''),
              message: 'Network error',
            ));

        // act & assert
        expect(
          () => dataSource.generateResetToken(testUsername),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
} 