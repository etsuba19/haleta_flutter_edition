import '../../domain/quiz/usecases/view_quiz_use_case.dart';
import '../../domain/quiz/usecases/continue_quiz_use_case.dart';

class PreviousExamController {
  final ViewQuizUseCase _viewQuizUseCase;
  final ContinueQuizUseCase _continueQuizUseCase;

  PreviousExamController({
    required ViewQuizUseCase viewQuizUseCase,
    required ContinueQuizUseCase continueQuizUseCase,
  })  : _viewQuizUseCase = viewQuizUseCase,
        _continueQuizUseCase = continueQuizUseCase;

  Future<void> viewQuiz(String quizId) async {
    if (quizId.isEmpty) {
      throw ArgumentError('First quiz ID cannot be empty.');
    }

    // Application logic to view the quiz
    await _viewQuizUseCase.execute(quizId);
  }

  Future<void> continueQuiz(String quizId) async {
    if (quizId.isEmpty) {
      throw ArgumentError('Second quiz ID cannot be empty.');
    }

    // Application logic to continue the quiz
    await _continueQuizUseCase.execute(quizId);
  }
}
