import '../repositories/quiz_repository.dart';
import '../entities/quiz.dart';

class ViewQuizUseCase {
  final QuizRepository _quizRepository;

  ViewQuizUseCase(this._quizRepository);

  Future<Quiz> execute(String quizId) async {
    final quizzes = await _quizRepository.fetchQuizzes();
    final quiz = quizzes.firstWhere(
          (q) => q.id == quizId,
      orElse: () => throw Exception('Quiz not found'),
    );
    return quiz;
  }
}
