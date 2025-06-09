import 'package:dio/dio.dart';
import '../../../../infrastructure/core/network/dio_client.dart';

abstract class AdminHomeRemoteDataSource {
  Future<Map<String, dynamic>> fetchStats();
}

class AdminHomeRemoteDataSourceImpl implements AdminHomeRemoteDataSource {
  final DioClient dioClient;

  AdminHomeRemoteDataSourceImpl(this.dioClient);

  @override
  Future<Map<String, dynamic>> fetchStats() async {
    try {
      final response = await dioClient.get('/admin/stats');
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to fetch admin stats. Status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error occurred: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
