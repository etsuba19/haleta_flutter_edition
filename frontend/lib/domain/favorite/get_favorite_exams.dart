import 'favorite_quiz.dart';
import '../../infrastructure/favorite/local_favorite_quiz_datasource.dart';

class GetFavoriteExam {
  final LocalFavoriteQuizDataSource repository;

  GetFavoriteExam(this.repository);

  Future<List<FavoriteQuiz>> call() async {
    return repository.getFavorites();
  }
}
