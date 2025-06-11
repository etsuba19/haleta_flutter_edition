import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/infrastructure/category/datasources/category_remote_data_source.dart';

void main() {
  late CategoryRemoteDataSourceImpl dataSource;

  setUp(() {
    dataSource = CategoryRemoteDataSourceImpl();
  });

  test('should return categories with expected data', () async {
    final result = await dataSource.getCategories();

    expect(result.length, 3);
    expect(result[0].title, 'ጀማሪ');
    expect(result[0].subtitle, '3 ጥያቄ * 3 ደቂቃ');
  });
}
