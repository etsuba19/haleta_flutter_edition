import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/domain/favorite/get_favorite_exams.dart';
import 'package:frontend/domain/favorite/favorite_quiz.dart';
import 'package:frontend/infrastructure/favorite/local_favorite_quiz_datasource.dart';

// Mock class using mocktail
class MockLocalFavoriteQuizDataSource extends Mock implements LocalFavoriteQuizDataSource {}

void main() {
  late GetFavoriteExam useCase;
  late MockLocalFavoriteQuizDataSource mockRepository;

  setUp(() {
    mockRepository = MockLocalFavoriteQuizDataSource();
    useCase = GetFavoriteExam(mockRepository);
  });

  test('returns list of FavoriteQuiz from repository', () async {
    final quizzes = [
      FavoriteQuiz(id: '1', title: 'Quiz 1', description: 'Desc 1'),
      FavoriteQuiz(id: '2', title: 'Quiz 2', description: 'Desc 2'),
    ];

    // Since getFavorites() returns List<FavoriteQuiz> synchronously,
    // use thenReturn instead of thenAnswer
    when(() => mockRepository.getFavorites()).thenReturn(quizzes);

    final result = useCase.call();

    expect(result, quizzes);
    verify(() => mockRepository.getFavorites()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
