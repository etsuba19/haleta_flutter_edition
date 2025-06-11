import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/domain/quiz_list/entities/quiz.dart';
import 'package:frontend/infrastructure/quiz/datasources/quiz_remote_data_source.dart';
import 'package:frontend/infrastructure/quiz/repositories_impl/quiz_repository_impl.dart';

class MockRemoteDataSource extends Mock implements QuizRemoteDataSource {}
class FakeQuiz extends Fake implements Quiz {}

void main() {
  late QuizRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;

  setUpAll(() {
    registerFallbackValue(FakeQuiz());
  });

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = QuizRepositoryImpl(mockRemoteDataSource);
  });

  test('should return list of quizzes from remote data source', () async {
    final quizzes = [
      Quiz(
        id: 'q1',
        title: 'Test Quiz 1',
      ),
    ];

    when(() => mockRemoteDataSource.getQuizzes())
        .thenAnswer((_) async => quizzes);

    final result = await repository.fetchQuizzes();

    expect(result, quizzes);
    verify(() => mockRemoteDataSource.getQuizzes()).called(1);
  });
}
