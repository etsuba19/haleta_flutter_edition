abstract class ResourcesRemoteDataSource {
  Future<List<String>> fetchResources();
  Future<void> addResource(String resourceId);
  Future<void> removeResource(String resourceId);
}
