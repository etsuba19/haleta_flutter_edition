import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/infrastructure/choice/repositories_impl/choice_repository_impl.dart';
import 'package:frontend/infrastructure/choice/datasources/choice_remote_data_source.dart';

// Mock class with mocktail
class MockChoiceRemoteDataSource extends Mock implements ChoiceRemoteDataSource {}

void main() {
  late MockChoiceRemoteDataSource mockDataSource;
  late ChoiceRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockChoiceRemoteDataSource();
    repository = ChoiceRepositoryImpl(mockDataSource);
  });

  test('goToQuiz should call navigateToQuiz on data source', () async {
    when(() => mockDataSource.navigateToQuiz()).thenAnswer((_) async {});

    await repository.goToQuiz();

    verify(() => mockDataSource.navigateToQuiz()).called(1);
  });

  test('goToResources should call navigateToResources on data source', () async {
    when(() => mockDataSource.navigateToResources()).thenAnswer((_) async {});

    await repository.goToResources();

    verify(() => mockDataSource.navigateToResources()).called(1);
  });
}
