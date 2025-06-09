import 'package:dio/dio.dart';

abstract class AddResourceRemoteDataSource {
  Future<void> createResource({
    required String title,
    required String description,
    required String link,
  });
}

class AddResourceRemoteDataSourceImpl implements AddResourceRemoteDataSource {
  final Dio dio;

  AddResourceRemoteDataSourceImpl(this.dio);

  @override
  Future<void> createResource({
    required String title,
    required String description,
    required String link,
  }) async {
    try {
      await dio.post(
        '/resources',
        data: {
          'title': title,
          'description': description,
          'link': link,
        },
      );
    } catch (e) {
      throw Exception('Failed to create resource: $e');
    }
  }
}
