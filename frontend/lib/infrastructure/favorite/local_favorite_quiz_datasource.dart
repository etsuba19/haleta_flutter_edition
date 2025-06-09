import '../../domain/favorite/favorite_quiz.dart';
import '../../domain/favorite/favorite_quiz_repository.dart';

class LocalFavoriteQuizDataSource implements FavoriteQuizRepository {
  final List<FavoriteQuiz> _storage = []; // simulate DB

  void saveFavorite(FavoriteQuiz quiz) {
    _storage.add(quiz);
  }

  List<FavoriteQuiz> getFavorites() {
    return _storage;
  }

  FavoriteQuiz? getQuizById(String id) {
    return _storage.firstWhere((quiz) => quiz.id == id, orElse: () => FavoriteQuiz(id: '', title: '', description: ''));
  }

  @override
  Future<void> continueQuiz(FavoriteQuiz quiz) {
    // TODO: implement continueQuiz
    throw UnimplementedError();
  }

  @override
  Future<void> viewQuiz(FavoriteQuiz quiz) {
    // TODO: implement viewQuiz
    throw UnimplementedError();
  }
}
