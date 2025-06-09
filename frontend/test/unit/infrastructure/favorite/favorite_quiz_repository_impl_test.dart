import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:your_app_path/domain/favorite/favorite_quiz.dart';
import 'package:your_app_path/infrastructure/favorite/favorite_quiz_repository_impl.dart';
import 'package:your_app_path/infrastructure/favorite/local_favorite_quiz_datasource.dart';

// Mock class
class MockLocalFavoriteQuizDataSource extends Mock implements LocalFavoriteQuizDataSource {}

void main() {
  late MockLocalFavoriteQuizDataSource mockDataSource;
  late FavoriteQuizRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockLocalFavoriteQuizDataSource();
    repository = FavoriteQuizRepositoryImpl(mockDataSource);
  });

  test('viewQuiz completes without error', () async {
    final quiz = FavoriteQuiz(id: 'abc', title: 'Sample', description: 'Test');
    await repository.viewQuiz(quiz);
    // no assert - just ensuring it doesn't throw
  });

  test('continueQuiz completes without error', () async {
    final quiz = FavoriteQuiz(id: 'xyz', title: 'Sample', description: 'Test');
    await repository.continueQuiz(quiz);
  });
}
