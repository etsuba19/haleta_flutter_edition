import '../../application/favorite/view_favorite_quiz.dart';
import '../../application/favorite/continue_favorite_quiz.dart';
import '../../domain/favorite/favorite_quiz.dart';

class FavoriteQuizController {
  final ViewFavoriteQuiz _viewFavoriteQuiz;
  final ContinueFavoriteQuiz _continueFavoriteQuiz;

  FavoriteQuizController({
    required ViewFavoriteQuiz viewFavoriteQuiz,
    required ContinueFavoriteQuiz continueFavoriteQuiz,
  })  : _viewFavoriteQuiz = viewFavoriteQuiz,
        _continueFavoriteQuiz = continueFavoriteQuiz;

  Future<void> viewQuiz(String quizId) async {
    if (quizId.isEmpty) {
      throw ArgumentError('Quiz ID is empty');
    }

    final quiz = FavoriteQuiz(id: quizId, title: '', description: '');
    await _viewFavoriteQuiz.call(quiz);
  }

  Future<void> continueQuiz(String quizId) async {
    if (quizId.isEmpty) {
      throw ArgumentError('Quiz ID is empty');
    }

    final quiz = FavoriteQuiz(id: quizId, title: '', description: '');
    await _continueFavoriteQuiz.call(quiz);
  }
}
