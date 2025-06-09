import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../infrastructure/signup/repositories_yaml/signup_repository_yaml.dart';
import '../../domain/signup/repositories/signup_repository.dart';
import '../../../application/signup/usecases/signup_usecase.dart';
import 'package:dio/dio.dart';

final dioProvider = Provider((ref) => Dio());

final signupRepositoryProvider = Provider<SignupRepository>((ref) {
  final dio = ref.read(dioProvider);
  return SignupRepositoryImpl(dio);
});

final signupUseCaseProvider = Provider<SignupUseCase>((ref) {
  final repository = ref.read(signupRepositoryProvider);
  return SignupUseCase(repository);
});
