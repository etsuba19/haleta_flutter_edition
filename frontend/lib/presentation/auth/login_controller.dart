import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginController extends StateNotifier<bool> {
  LoginController() : super(false);

  String username = '';
  String password = '';
  String role = '';

  void setUsername(String value) {
    username = value;
    _notify();
  }

  void setPassword(String value) {
    password = value;
    _notify();
  }

  void setRole(String value) {
    role = value;
    _notify();
  }

  void _notify() {
    state = !state;
  }
}

final loginControllerProvider = StateNotifierProvider<LoginController, bool>(
  (ref) => LoginController(),
);
