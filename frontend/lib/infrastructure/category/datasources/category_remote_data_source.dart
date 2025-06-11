// lib/infrastructure/category/datasources/category_remote_data_source.dart
import '../../../domain/category/entities/category.dart';

abstract class CategoryRemoteDataSource {
  Future<List<Category>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  @override
  Future<List<Category>> getCategories() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      Category(id: '1', title: 'ጀማሪ', subtitle: '3 ጥያቄ * 3 ደቂቃ'),
      Category(id: '2', title: 'መካከለኛ', subtitle: '3 ጥያቄ * 3 ደቂቃ'),
      Category(id: '3', title: 'አዋቂ', subtitle: '3 ጥያቄ * 3 ደቂቃ'),
    ];
  }
}
