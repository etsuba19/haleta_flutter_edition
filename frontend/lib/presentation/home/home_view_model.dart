// lib/presentation/home/home_view_model.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, bool>((ref) {
  return HomeViewModel();
});

class HomeViewModel extends StateNotifier<bool> {
  HomeViewModel() : super(false);

  void start() {
    // maybe set state to true or do something
  }
}
