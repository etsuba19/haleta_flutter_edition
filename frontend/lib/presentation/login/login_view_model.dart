import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginViewModel extends StateNotifier<bool> {
  LoginViewModel() : super(false); // Used only to trigger rebuilds

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

  // void login() {
  //   print('Logging in with:');
  //   print('Username: $username');
  //   print('Password: $password');
  //   print('Role: $role');
  //   // TODO: Add login logic here
  // }

  void _notify() {
    // Flip state to trigger a rebuild
    state = !state;
  }
}

final loginViewModelProvider = StateNotifierProvider<LoginViewModel, bool>(
  (ref) => LoginViewModel(),
);
