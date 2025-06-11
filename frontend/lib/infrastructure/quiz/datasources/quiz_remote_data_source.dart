import '../../../domain/quiz/entities/quiz.dart';

class QuizRemoteDataSource {
  Future<List<Quiz>> getQuizzes() async {
    // Dummy data (replace with real API later)
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      Quiz(
        id: 'q1',
        question: 'አሁን ምን ነው?',
        options: ['እባክህ', 'ወደ ኋላ', 'ወደ ፊት', 'እንቅስቃሴ'],
        correctAnswer: 'ወደ ፊት',
      ),
      Quiz(
        id: 'q2',
        question: 'ቀን ማንኛው ነው?',
        options: ['ሰኞ', 'ማክሰኞ', 'ረቡዕ', 'ሐሙስ'],
        correctAnswer: 'ሰኞ',
      ),
    ];
  }
}
