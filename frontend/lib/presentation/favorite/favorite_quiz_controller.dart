import '../../domain/quiz/usecases/view_quiz_use_case.dart';
import '../../domain/quiz/usecases/continue_quiz_use_case.dart';

class FavoriteQuizController {
  final ViewQuizUseCase _viewQuizUseCase;
  final ContinueQuizUseCase _continueQuizUseCase;

  FavoriteQuizController({
    required ViewQuizUseCase viewQuizUseCase,
    required ContinueQuizUseCase continueQuizUseCase,
  })  : _viewQuizUseCase = viewQuizUseCase,
        _continueQuizUseCase = continueQuizUseCase;

  Future<void> viewQuiz(String quizId) async {
    if (quizId.isEmpty) {
      throw ArgumentError('Quiz ID is empty');
    }

    // Replace with actual domain logic
    await _viewQuizUseCase.execute(quizId);
  }

  Future<void> continueQuiz(String quizId) async {
    if (quizId.isEmpty) {
      throw ArgumentError('Quiz ID is empty');
    }

    // Replace with actual domain logic
    await _continueQuizUseCase.execute(quizId);
  }
}
