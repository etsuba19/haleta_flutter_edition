import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../application/signup/signup_provider.dart';
import '../../../domain/signup/entities/signup_entity.dart';
import '../../../application/signup/usecases/signup_usecase.dart';

final signupControllerProvider =
    StateNotifierProvider<SignupController, void>((ref) {
  final useCase = ref.read(signupUseCaseProvider);
  return SignupController(useCase);
});

class SignupController extends StateNotifier<void> {
  final SignupUseCase useCase;

  SignupController(this.useCase) : super(null);

  // String _email = '';
  String _username = '';
  String _password = '';

  // void setEmail(String value) => _email = value;
  void setUsername(String value) => _username = value;
  void setPassword(String value) => _password = value;

  Future<void> signup() async {
    final data = SignupData(
      // email: _email,
      username: _username,
      password: _password,
    );
    await useCase(data);
  }
}
