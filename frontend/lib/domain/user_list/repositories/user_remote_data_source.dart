import 'package:dio/dio.dart';
import '../../../domain/user_list/entities/user.dart';

abstract class UserRemoteDataSource {
  Future<List<User>> getUsers();
  Future<void> deleteUser(String id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSourceImpl(this.dio);

  @override
  Future<List<User>> getUsers() async {
    final response = await dio.get('/users');

    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      return data.map((json) => User(
        id: json['id'] as String,
        name: json['name'] as String,
      )).toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    final response = await dio.delete('/users/$id');
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete user with id $id');
    }
  }
}
