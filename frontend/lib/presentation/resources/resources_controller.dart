import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/resources/entities/resource.dart';
import '../../application/resources/usecases/resource_usecase_types.dart';

final getResourcesProvider = Provider<GetResources>((ref) {
  throw UnimplementedError(); // Override in main.dart or test
});

final removeResourceProvider = Provider<RemoveResource>((ref) {
  throw UnimplementedError(); // Override in main.dart or test
});

final resourcesControllerProvider =
StateNotifierProvider<ResourcesController, AsyncValue<List<Resource>>>(
      (ref) => ResourcesController(
    ref.read(getResourcesProvider),
    ref.read(removeResourceProvider),
  ),
);

class ResourcesController extends StateNotifier<AsyncValue<List<Resource>>> {
  final GetResources _getResources;
  final RemoveResource _removeResource;

  ResourcesController(this._getResources, this._removeResource)
      : super(const AsyncValue.loading()) {
    loadResources();
  }

  Future<void> loadResources() async {
    try {
      final resources = await _getResources();
      state = AsyncValue.data(resources);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> removeResource(String id) async {
    try {
      await _removeResource(id);
      state = state.whenData(
            (resources) => resources.where((r) => r.id != id).toList(),
      );
    } catch (error) {
      // Optional: handle error
    }
  }
}
