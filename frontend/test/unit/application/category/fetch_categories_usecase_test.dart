import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/domain/category/entities/category.dart';
import 'package:frontend/domain/category/repositories/category_repository.dart';
import 'package:frontend/application/category/usecases/fetch_categories.dart';

// Mock class
class MockCategoryRepository extends Mock implements CategoryRepository {}

void main() {
  late FetchCategories useCase;
  late MockCategoryRepository mockRepo;

  setUp(() {
    mockRepo = MockCategoryRepository();
    useCase = FetchCategories(mockRepo);
  });

  test('should return list of categories from repository', () async {
    final categories = [
      Category(id: '1', title: 'Science', subtitle: 'Basic science facts'),
    ];

    when(() => mockRepo.fetchCategories()).thenAnswer((_) async => categories);

    final result = await useCase();

    expect(result, categories);
    verify(() => mockRepo.fetchCategories()).called(1);
  });
}
