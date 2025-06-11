import 'package:dio/dio.dart';
import '../core/network/http_client.dart';

class CategoryService {
  final HttpClient _httpClient = HttpClient();

  // Get all categories
  Future<List<Map<String, dynamic>>> getAllCategories() async {
    try {
      final response = await _httpClient.dio.get('/category');
      
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data['categories']);
      } else {
        throw Exception('Failed to get categories');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to get categories');
      } else {
        throw Exception('Network error');
      }
    }
  }

  // Get category by ID
  Future<Map<String, dynamic>> getCategoryById(String id) async {
    try {
      final response = await _httpClient.dio.get('/category/$id');
      
      if (response.statusCode == 200) {
        return response.data['category'];
      } else {
        throw Exception('Failed to get category');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to get category');
      } else {
        throw Exception('Network error');
      }
    }
  }

  // Get quizzes by category
  Future<List<Map<String, dynamic>>> getQuizzesByCategory(String categoryId) async {
    try {
      final response = await _httpClient.dio.get('/quiz/category/$categoryId');
      
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data['quizzes']);
      } else {
        throw Exception('Failed to get quizzes for category');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to get quizzes for category');
      } else {
        throw Exception('Network error');
      }
    }
  }
} 