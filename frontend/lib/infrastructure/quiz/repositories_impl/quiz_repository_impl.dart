import '../../../domain/quiz_list/entities/quiz.dart';
import '../../../domain/quiz/repositories/quiz_repository.dart';
import '../datasources/quiz_remote_data_source.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizRemoteDataSource remoteDataSource;

  QuizRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Quiz>> fetchQuizzes() {
    return remoteDataSource.getQuizzes();
  }
}
