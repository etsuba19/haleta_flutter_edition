import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final choiceViewModelProvider = Provider<ChoiceViewModel>((ref) {
  return ChoiceViewModel(ref);
});

class ChoiceViewModel {
  final Ref ref;

  ChoiceViewModel(this.ref);

  void onQuizSelected() {
    // TODO: Navigate to quiz screen
    debugPrint('Member selected — navigate to quiz screen');
  }

  void onResourceSelected() {
    // TODO: Navigate to resource screen
    debugPrint('Guardian selected — navigate to resource screen');
  }
}
