import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/application/signup/signup_provider.dart';
import 'package:frontend/application/signup/usecases/signup_usecase.dart';
import 'package:frontend/domain/signup/repositories/signup_repository.dart';
import 'package:frontend/infrastructure/signup/repositories_yaml/signup_repository_yaml.dart';
import 'package:dio/dio.dart';

void main() {
  test('dioProvider provides a Dio instance', () {
    final container = ProviderContainer();
    final dio = container.read(dioProvider);
    expect(dio, isA<Dio>());
  });

  test('signupRepositoryProvider provides a SignupRepositoryImpl', () {
    final container = ProviderContainer();
    final repository = container.read(signupRepositoryProvider);
    expect(repository, isA<SignupRepositoryImpl>());
  });

  test('signupUseCaseProvider provides a SignupUseCase', () {
    final container = ProviderContainer();
    final useCase = container.read(signupUseCaseProvider);
    expect(useCase, isA<SignupUseCase>());
  });
}
