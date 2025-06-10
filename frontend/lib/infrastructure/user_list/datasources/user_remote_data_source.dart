import 'package:dio/dio.dart';
import '../../../domain/user_list/entities/user.dart';
import '../../core/network/dio_client.dart';

abstract class UserRemoteDataSource {
  Future<List<User>> getUsers();
  Future<void> deleteUser(String id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final DioClient dioClient;

  UserRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<User>> getUsers() async {
    try {
      final response = await dioClient.get('/users');

      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((json) => User(
          id: json['id'].toString(),
          name: json['name'].toString(),
        )).toList();
      } else {
        throw Exception('Failed to fetch users');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    try {
      final response = await dioClient.delete('/users/$id');

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to delete user with id $id');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }
}
