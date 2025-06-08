import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final choiceViewModelProvider = Provider<ChoiceViewModel>((ref) {
  return ChoiceViewModel(ref);
});

class ChoiceViewModel {
  final Ref ref;

  ChoiceViewModel(this.ref);

  void onQuizSelected(BuildContext context) {
    // TODO: Navigate to quiz screen
    GoRouter.of(context).go('/category');
  }

  void onResourceSelected() {
    // TODO: Navigate to resource screen
    debugPrint('Guardian selected — navigate to resource screen');
  }
}
