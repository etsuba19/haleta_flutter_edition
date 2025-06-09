import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/choice/repositories/choice_repository.dart';

class ChoiceRepositoryImpl implements ChoiceRepository {
  final BuildContext context;

  ChoiceRepositoryImpl(this.context);

  @override
  void goToQuiz() {
    GoRouter.of(context).go('/category');
  }

  @override
  void goToResources() {
    GoRouter.of(context).go('/resources');
  }
}
