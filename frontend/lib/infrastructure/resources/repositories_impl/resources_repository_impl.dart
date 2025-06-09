import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/infrastructure/resources/datasources/resources_remote_data_source.dart';

class MockResourcesRemoteDataSource implements ResourcesRemoteDataSource {
  final List<String> _mockData = ['Resource A', 'Resource B'];

  @override
  Future<List<String>> fetchResources() async {
    return _mockData;
  }

  @override
  Future<void> addResource(String resourceId) async {
    _mockData.add(resourceId);
  }

  @override
  Future<void> removeResource(String resourceId) async {
    _mockData.remove(resourceId);
  }
}

void main() {
  late MockResourcesRemoteDataSource dataSource;

  setUp(() {
    dataSource = MockResourcesRemoteDataSource();
  });

  test('fetchResources returns all resources', () async {
    final result = await dataSource.fetchResources();
    expect(result, ['Resource A', 'Resource B']);
  });

  test('addResource adds a new resource', () async {
    await dataSource.addResource('Resource C');
    final result = await dataSource.fetchResources();
    expect(result.contains('Resource C'), true);
  });

  test('removeResource removes the given resource', () async {
    await dataSource.removeResource('Resource A');
    final result = await dataSource.fetchResources();
    expect(result.contains('Resource A'), false);
  });
}
