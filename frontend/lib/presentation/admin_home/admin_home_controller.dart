import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Removed: import '../../../navigation/app_router.dart';
import '../../../infrastructure/core/network/dio_client.dart';
import '../../../infrastructure/admin_home/datasources/admin_home_remote_data_source.dart';
import '../../../infrastructure/admin_home/repositories_impl/admin_home_repository_impl.dart';

final adminHomeControllerProvider =
StateNotifierProvider<AdminHomeController, void>((ref) {
  final dio = Dio();
  final dioClient = DioClient(dio);
  final remoteDataSource = AdminHomeRemoteDataSourceImpl(dioClient);
  final repository = AdminHomeRepositoryImpl(remoteDataSource);
  return AdminHomeController(ref, repository);
});

class AdminHomeController extends StateNotifier<void> {
  final Ref ref;
  final AdminHomeRepositoryImpl repository;

  AdminHomeController(this.ref, this.repository) : super(null);

  // All navigation methods now just print to the console
  void navigateToUserList(BuildContext context) {
    debugPrint("User List button pressed - No navigation for now.");
  }

  void navigateToQuizList(BuildContext context) {
    debugPrint("Quiz List button pressed - No navigation for now.");
  }

  void navigateToResourceList(BuildContext context) {
    debugPrint("Resource List button pressed - No navigation for now.");
  }

  void logout() {
    debugPrint("Logout button pressed - No navigation for now.");
  }
}
