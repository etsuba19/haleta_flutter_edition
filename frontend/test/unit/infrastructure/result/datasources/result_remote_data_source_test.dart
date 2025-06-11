import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import 'package:frontend/infrastructure/result/datasources/result_remote_data_source.dart';
import 'package:frontend/domain/result/entities/result.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ResultRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ResultRemoteDataSourceImpl(client: mockHttpClient);
  });

  const tResultJson = '''
  {
    "id": "r1",
    "title": "Final Quiz Result",
    "score": 5,
    "total": 10
  }
  ''';

  final tResult = Result(
    id: 'r1',
    title: 'Final Quiz Result',
    score: 5,
    total: 10,
  );

  test('should return List<Result> when the response code is 200', () async {
    // arrange
    when(() => mockHttpClient.get(any()))
        .thenAnswer((_) async => http.Response('[$tResultJson]', 200)); // wrap JSON in array

    // act
    final resultList = await dataSource.fetchResults();

    // assert
    expect(resultList, isA<List<Result>>());
    expect(resultList.length, 1);
    final result = resultList[0];
    expect(result.id, tResult.id);
    expect(result.title, tResult.title);
    expect(result.score, tResult.score);
    expect(result.total, tResult.total);
  });

  test('should throw an exception when response code is not 200', () async {
    // arrange
    when(() => mockHttpClient.get(any()))
        .thenAnswer((_) async => http.Response('Error', 404));

    // act & assert
    expect(() => dataSource.fetchResults(), throwsException);
  });
}
