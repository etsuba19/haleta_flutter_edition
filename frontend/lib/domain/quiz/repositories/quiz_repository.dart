import '../entities/question.dart';
import '../entities/quiz_session.dart';

abstract class QuizRepository {
  Future<Map<String, dynamic>> getQuizById(String id);
  Future<List<Question>> getQuizQuestions(String quizId);
  Future<QuizSession> startQuizSession(String quizId, String quizTitle, List<Question> questions);
  Future<QuizSession> answerQuestion(QuizSession session, String questionId, String selectedOptionId);
  Future<QuizSession> completeQuizSession(QuizSession session);
  Future<List<QuizSession>> getUserQuizHistory();
} 