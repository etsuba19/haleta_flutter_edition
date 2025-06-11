import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../domain/result/entities/result.dart';

abstract class ResultRemoteDataSource {
  Future<List<Result>> fetchResults();
}

class ResultRemoteDataSourceImpl implements ResultRemoteDataSource {
  final http.Client client;

  ResultRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Result>> fetchResults() async {
    final response = await client.get(Uri.parse('https://api.example.com/results'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Result(
        id: json['id'],
        title: json['title'],
        score: json['score'],
        total: json['total'],
      )).toList();
    } else {
      throw Exception('Failed to load results');
    }
  }
}
