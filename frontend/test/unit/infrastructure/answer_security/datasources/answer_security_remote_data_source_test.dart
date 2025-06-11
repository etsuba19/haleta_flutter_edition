import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:frontend/domain/answer_security/entities/answer_security.dart';
import 'package:frontend/infrastructure/answer_security/datasources/answer_security_remote_data_source.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late AnswerSecurityRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = AnswerSecurityRemoteDataSourceImpl(dio: mockDio);
    
    // Register fallback values
    registerFallbackValue(RequestOptions(path: ''));
  });

  group('AnswerSecurityRemoteDataSource', () {
    const testUsername = 'testuser';
    const testAnswer = 'Smith';
    const testQuestion = 'What is your mother\'s maiden name?';
    const testAnswerSecurity = AnswerSecurity(
      username: testUsername,
      securityQuestion: testQuestion,
      securityAnswer: testAnswer,
      isVerified: true,
      verificationToken: 'verification-token-123',
    );

    group('verifySecurityAnswer', () {
      test('should return AnswerSecurity when verification is successful', () async {
        // arrange
        when(() => mockDio.post(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            )).thenAnswer((_) async => Response(
                  statusCode: 200,
                  data: testAnswerSecurity.toJson(),
                  requestOptions: RequestOptions(path: ''),
                ));

        // act
        final result = await dataSource.verifySecurityAnswer(testUsername, testAnswer);

        // assert
        expect(result.username, testAnswerSecurity.username);
        expect(result.isVerified, testAnswerSecurity.isVerified);
      });

      test('should throw exception when request fails', () async {
        // arrange
        when(() => mockDio.post(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            )).thenThrow(DioException(
              requestOptions: RequestOptions(path: ''),
              message: 'Network error',
            ));

        // act & assert
        expect(
          () => dataSource.verifySecurityAnswer(testUsername, testAnswer),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('getSecurityQuestion', () {
      test('should return security question when user is found', () async {
        // arrange
        when(() => mockDio.get(
              any(),
              options: any(named: 'options'),
            )).thenAnswer((_) async => Response(
                  statusCode: 200,
                  data: {'question': testQuestion},
                  requestOptions: RequestOptions(path: ''),
                ));

        // act
        final result = await dataSource.getSecurityQuestion(testUsername);

        // assert
        expect(result, testQuestion);
      });

      test('should throw exception when user is not found', () async {
        // arrange
        when(() => mockDio.get(
              any(),
              options: any(named: 'options'),
            )).thenThrow(DioException(
              requestOptions: RequestOptions(path: ''),
              response: Response(statusCode: 404, requestOptions: RequestOptions(path: '')),
            ));

        // act & assert
        expect(
          () => dataSource.getSecurityQuestion(testUsername),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('updateSecurityQuestion', () {
      test('should return true when update is successful', () async {
        // arrange
        when(() => mockDio.put(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            )).thenAnswer((_) async => Response(
                  statusCode: 200,
                  requestOptions: RequestOptions(path: ''),
                ));

        // act
        final result = await dataSource.updateSecurityQuestion(testUsername, testQuestion, testAnswer);

        // assert
        expect(result, true);
      });

      test('should throw exception when request fails', () async {
        // arrange
        when(() => mockDio.put(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            )).thenThrow(DioException(
              requestOptions: RequestOptions(path: ''),
              message: 'Network error',
            ));

        // act & assert
        expect(
          () => dataSource.updateSecurityQuestion(testUsername, testQuestion, testAnswer),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
} 