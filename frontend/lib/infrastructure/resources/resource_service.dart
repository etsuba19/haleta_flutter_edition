import 'package:dio/dio.dart';
import '../core/network/http_client.dart';

class ResourceService {
  final HttpClient _httpClient = HttpClient();

  // Get all resources
  Future<List<Map<String, dynamic>>> getAllResources() async {
    try {
      final response = await _httpClient.dio.get('/api/resources');
      
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data['resources']);
      } else {
        throw Exception('Failed to get resources');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to get resources');
      } else {
        throw Exception('Network error');
      }
    }
  }

  // Get resource by ID
  Future<Map<String, dynamic>> getResourceById(String id) async {
    try {
      final response = await _httpClient.dio.get('/api/resources/$id');
      
      if (response.statusCode == 200) {
        return response.data['resource'];
      } else {
        throw Exception('Failed to get resource');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to get resource');
      } else {
        throw Exception('Network error');
      }
    }
  }

  // Get resource categories
  Future<List<String>> getResourceCategories() async {
    try {
      final response = await _httpClient.dio.get('/api/resources/categories');
      
      if (response.statusCode == 200) {
        return List<String>.from(response.data['categories']);
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

  // Create resource (admin only)
  Future<Map<String, dynamic>> createResource(Map<String, dynamic> resourceData) async {
    try {
      final response = await _httpClient.dio.post(
        '/api/resources',
        data: resourceData,
      );
      
      if (response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Failed to create resource');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to create resource');
      } else {
        throw Exception('Network error');
      }
    }
  }

  // Update resource (admin only)
  Future<Map<String, dynamic>> updateResource(String id, Map<String, dynamic> resourceData) async {
    try {
      final response = await _httpClient.dio.put(
        '/api/resources/$id',
        data: resourceData,
      );
      
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to update resource');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to update resource');
      } else {
        throw Exception('Network error');
      }
    }
  }

  // Delete resource (admin only)
  Future<bool> deleteResource(String id) async {
    try {
      final response = await _httpClient.dio.delete('/api/resources/$id');
      
      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to delete resource');
      } else {
        throw Exception('Network error');
      }
    }
  }
} 