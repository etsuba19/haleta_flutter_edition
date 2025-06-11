import '../../quiz_list/entities/quiz.dart';

abstract class QuizRepository {
  Future<List<Quiz>> fetchQuizzes();
}
