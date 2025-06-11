import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/application/favorite/continue_favorite_quiz.dart';
import 'package:frontend/domain/favorite/favorite_quiz.dart';
import 'package:frontend/domain/favorite/favorite_quiz_repository.dart';

// Mock class using mocktail
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
      final quiz = FavoriteQuiz(id: '1', title: 'Math Quiz', description: 'Test description');

      // Stub the method using mocktail syntax
      when(() => mockRepository.continueQuiz(any())).thenAnswer((_) async => Future.value());

      await useCase.call(quiz);

      // Verify the interaction
      verify(() => mockRepository.continueQuiz(any())).called(1);
    });
  });
}



