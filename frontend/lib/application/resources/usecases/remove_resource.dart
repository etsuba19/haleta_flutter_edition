import 'package:quiz_admin/domain/resources/repositories/resource_repository.dart';

class RemoveResource {
  final ResourceRepository repository;

  RemoveResource(this.repository);

  Future<void> call(String id) async {
    await repository.removeResource(id);
  }
}
