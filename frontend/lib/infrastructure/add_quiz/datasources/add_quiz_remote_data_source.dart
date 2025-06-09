import 'package:dio/dio.dart';
import '../../../domain/add_quiz/entities/quiz.dart';

abstract class AddQuizRemoteDataSource {
  Future<void> createQuiz(Quiz quiz);
}

class AddQuizRemoteDataSourceImpl implements AddQuizRemoteDataSource {
  final Dio dio;

  AddQuizRemoteDataSourceImpl(this.dio);

  @override
  Future<void> createQuiz(Quiz quiz) async {
    final data = {
      'question': quiz.question,
      'options': quiz.options,
    };

    final response = await dio.post('/quizzes', data: data);

    if (response.statusCode != 201) {
      throw Exception('Failed to create quiz');
    }
  }
}
