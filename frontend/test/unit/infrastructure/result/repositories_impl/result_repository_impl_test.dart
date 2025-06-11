import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  const tResponseBody = '''
  [
    {
      "id": "r1",
      "title": "Final Quiz",
      "score": 7,
      "total": 10
    },
    {
      "id": "r2",
      "title": "Midterm Quiz",
      "score": 6,
      "total": 10
    }
  ]
  ''';

  final tResults = [
    Result(id: 'r1', title: 'Final Quiz', score: 7, total: 10),
    Result(id: 'r2', title: 'Midterm Quiz', score: 6, total: 10),
  ];

  test('should return List<Result> when the response code is 200', () async {
    // arrange
    when(() => mockHttpClient.get(any()))
        .thenAnswer((_) async => http.Response(tResponseBody, 200));

    // act
    final results = await dataSource.fetchResults();

    // assert
    expect(results.length, tResults.length);
    for (int i = 0; i < results.length; i++) {
      expect(results[i].id, tResults[i].id);
      expect(results[i].title, tResults[i].title);
      expect(results[i].score, tResults[i].score);
      expect(results[i].total, tResults[i].total);
    }
  });

  test('should throw an exception when response code is not 200', () async {
    // arrange
    when(() => mockHttpClient.get(any()))
        .thenAnswer((_) async => http.Response('Error', 404));

    // act & assert
    expect(() => dataSource.fetchResults(), throwsException);
  });
}
