import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/domain/favorite/get_favorite_exams.dart';
import 'package:frontend/domain/favorite/favorite_quiz.dart';
import 'package:frontend/infrastructure/favorite/local_favorite_quiz_datasource.dart';

// Mock class
class MockLocalFavoriteQuizDataSource extends Mock implements LocalFavoriteQuizDataSource {}

void main() {
  late GetFavoriteExam useCase;
  late MockLocalFavoriteQuizDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockLocalFavoriteQuizDataSource();
    useCase = GetFavoriteExam(mockDataSource);
  });

  test('should return favorite quizzes from the data source', () async {
    // Arrange
    final mockQuizzes = [
      FavoriteQuiz(id: '1', title: 'Quiz 1', description: 'Description 1'),
      FavoriteQuiz(id: '2', title: 'Quiz 2', description: 'Description 2'),
    ];
    
    when(() => mockDataSource.getFavorites()).thenReturn(mockQuizzes);
    
    // Act
    final result = await useCase.call();
    
    // Assert
    expect(result, equals(mockQuizzes));
    verify(() => mockDataSource.getFavorites()).called(1);
    verifyNoMoreInteractions(mockDataSource);
  });
}


