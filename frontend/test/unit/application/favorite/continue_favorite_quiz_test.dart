import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:your_app_path/application/favorite/continue_favorite_quiz.dart';
import 'package:your_app_path/domain/favorite/favorite_quiz.dart';
import 'package:your_app_path/domain/favorite/favorite_quiz_repository.dart';

// Mock class using mockito
class MockFavoriteQuizRepository extends Mock implements FavoriteQuizRepository {}

void main() {
  group('ContinueFavoriteQuiz', () {
    late MockFavoriteQuizRepository mockRepository;
    late ContinueFavoriteQuiz useCase;

    setUp(() {
      mockRepository = MockFavoriteQuizRepository();
      useCase = ContinueFavoriteQuiz(mockRepository);
    });

    test('calls repository.continueQuiz with the correct quiz', () async {
      final quiz = FavoriteQuiz(id: '1', title: 'Math Quiz');

      // Stub the method to return a future
      when(mockRepository.continueQuiz(quiz)).thenAnswer((_) async => Future.value());

      await useCase.call(quiz);

      // Verify the interaction
      verify(mockRepository.continueQuiz(quiz)).called(1);
    });
  });
}
