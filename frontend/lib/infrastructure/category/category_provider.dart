import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/category/entities/category.dart';
import 'category_service.dart';

// Provider for CategoryService
final categoryServiceProvider = Provider<CategoryService>((ref) {
  return CategoryService();
});

// Provider for categories list
final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final categoryService = ref.read(categoryServiceProvider);
  final categoriesData = await categoryService.getAllCategories();
  
  return categoriesData.map((data) => Category(
    id: data['_id'] ?? '',
    name: data['name'] ?? '',
    imageUrl: data['imageUrl'] ?? '',
    quizCount: data['quizCount'] ?? 0,
  )).toList();
});

// Provider for a specific category by ID
final categoryByIdProvider = FutureProviderFamily<Category, String>((ref, id) async {
  final categoryService = ref.read(categoryServiceProvider);
  final categoryData = await categoryService.getCategoryById(id);
  
  return Category(
    id: categoryData['_id'] ?? '',
    name: categoryData['name'] ?? '',
    imageUrl: categoryData['imageUrl'] ?? '',
    quizCount: categoryData['quizCount'] ?? 0,
  );
});

// Provider for quizzes by category
final quizzesByCategoryProvider = FutureProviderFamily<List<Map<String, dynamic>>, String>((ref, categoryId) async {
  final categoryService = ref.read(categoryServiceProvider);
  return await categoryService.getQuizzesByCategory(categoryId);
});

// Provider to handle category operations
final categoryControllerProvider = Provider((ref) => CategoryController(ref));

class CategoryController {
  final Ref _ref;

  CategoryController(this._ref);

  Future<List<Category>> getCategories() async {
    final categoriesAsync = await _ref.read(categoriesProvider.future);
    return categoriesAsync;
  }

  Future<Category> getCategoryById(String id) async {
    final categoryAsync = await _ref.read(categoryByIdProvider(id).future);
    return categoryAsync;
  }

  Future<List<Map<String, dynamic>>> getQuizzesByCategory(String categoryId) async {
    final quizzesAsync = await _ref.read(quizzesByCategoryProvider(categoryId).future);
    return quizzesAsync;
  }
} 