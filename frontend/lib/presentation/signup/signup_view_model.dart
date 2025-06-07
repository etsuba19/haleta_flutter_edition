import 'package:flutter_riverpod/flutter_riverpod.dart';

final signupViewModelProvider = StateNotifierProvider<SignupViewModel, void>(
  (ref) => SignupViewModel(),
);

class SignupViewModel extends StateNotifier<void> {
  SignupViewModel() : super(null);

  String email = '';
  String username = '';
  String password = '';

  void updateEmail(String value) => email = value;
  void updateUsername(String value) => username = value;
  void updatePassword(String value) => password = value;

  Future<void> signup() async {
    // Add signup logic here (API call, validation, etc.)
    print('Signing up with: $email, $username, $password');
  }
}

