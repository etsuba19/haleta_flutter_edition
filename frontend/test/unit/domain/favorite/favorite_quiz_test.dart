import 'package:flutter_test/flutter_test.dart';
import 'package:your_app_path/domain/favorite/favorite_quiz.dart';

void main() {
  test('FavoriteQuiz.empty returns default values', () {
    final quiz = FavoriteQuiz.empty();

    expect(quiz.id, '');
    expect(quiz.title, '');
    expect(quiz.description, '');
  });
}
