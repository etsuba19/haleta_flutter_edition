import 'package:quiz_admin/domain/resources/entities/resource.dart';

typedef GetResources = Future<List<Resource>> Function();
typedef RemoveResource = Future<void> Function(String id);
