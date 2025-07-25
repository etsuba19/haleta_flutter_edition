// lib/domain/quiz/usecases/continue_quiz_use_case.dart

import '../repositories/quiz_repository.dart';
import '../../quiz_list/entities/quiz.dart';

class ContinueQuizUseCase {
  final QuizRepository _quizRepository;

  ContinueQuizUseCase(this._quizRepository);

  Future<Quiz> execute(String quizId) async {
    final quizzes = await _quizRepository.fetchQuizzes();
    final quiz = quizzes.firstWhere(
          (q) => q.id == quizId,
      orElse: () => throw Exception('Quiz not found'),
    );
    return quiz;
  }
} 