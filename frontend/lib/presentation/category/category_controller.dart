import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/category/entities/category.dart';
import '../../infrastructure/category/category_provider.dart';

class CategoryController {
  final Ref _ref;

  CategoryController(this._ref);

  Future<List<Category>> getCategories() async {
    return await _ref.read(categoryControllerProvider).getCategories();
  }

  Future<List<Map<String, dynamic>>> getQuizzesByCategory(String categoryId) async {
    return await _ref.read(categoryControllerProvider).getQuizzesByCategory(categoryId);
  }
}

final categoryControllerProvider = Provider((ref) => CategoryController(ref));
