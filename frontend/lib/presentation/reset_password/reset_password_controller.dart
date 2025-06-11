import '../../application/auth/usecases/reset_password.dart';

class ResetPasswordController {
  final ResetPasswordUseCase resetPasswordUseCase;
  final String username;

  ResetPasswordController(this.resetPasswordUseCase, this.username);

  Future<bool> resetPassword(String newPassword) async {
    return await resetPasswordUseCase(
      username: username,
      newPassword: newPassword,
    );
  }
} 