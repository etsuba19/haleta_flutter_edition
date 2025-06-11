import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/domain/category/entities/category.dart';
import 'package:frontend/infrastructure/category/datasources/category_remote_data_source.dart';
import 'package:frontend/infrastructure/category/repositories_impl/category_repository_impl.dart';

// Mock class using mocktail
class MockRemoteDataSource extends Mock implements CategoryRemoteDataSource {}

void main() {
  late CategoryRepositoryImpl repository;
  late MockRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockRemoteDataSource();
    repository = CategoryRepositoryImpl(mockDataSource);
  });

  test('should return list of categories from data source', () async {
    final categories = [
      Category(id: '1', title: 'Mocked Category', subtitle: 'Mock subtitle')
    ];

    // Arrange: mock the getCategories() call (not fetchCategories)
    when(() => mockDataSource.getCategories()).thenAnswer((_) async => categories);

    // Act: call the repository method
    final result = await repository.fetchCategories();

    // Assert: verify results and interactions
    expect(result, categories);
    verify(() => mockDataSource.getCategories()).called(1);
  });
}
