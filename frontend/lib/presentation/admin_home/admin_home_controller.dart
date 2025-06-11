import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

  // Navigate to User List page
  void navigateToUserList(BuildContext context) {
    context.go('/user-list');
  }

  // Navigate to Quiz List page
  void navigateToQuizList(BuildContext context) {
    context.go('/quiz-list');
  }

  // Navigate to Resources page
  void navigateToResourceList(BuildContext context) {
    context.go('/resources');
  }

  // Logout and return to home page
  void logout(BuildContext context) {
    context.go('/');
  }
}
