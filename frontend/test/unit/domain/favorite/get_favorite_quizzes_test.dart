import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:your_app_path/domain/favorite/get_favorite_exam.dart';
import 'package:your_app_path/domain/favorite/favorite_quiz.dart';
import 'package:your_app_path/infrastructure/favorite/local_favorite_quiz_datasource.dart';

// Mock class
class MockLocalFavoriteQuizDataSource extends Mock implements LocalFavoriteQuizDataSource {}

void main() {
  late GetFavoriteExam useCase;
  late MockLocalFavoriteQuizDataSource mockRepository;

  setUp(() {
    mockRepository = MockLocalFavoriteQuizDataSource();
    useCase = GetFavoriteExam(mockRepository);
  });

  test('returns list of FavoriteQuiz from repository', () async {
    final quizzes = [
      FavoriteQuiz(id: '1', title: 'Quiz 1', description: 'Desc 1'),
      FavoriteQuiz(id: '2', title: 'Quiz 2', description: 'Desc 2'),
    ];

    when(mockRepository.getFavorites()).thenAnswer((_) async => quizzes);

    final result = await useCase.call();

    expect(result, quizzes);
    verify(mockRepository.getFavorites()).calle
