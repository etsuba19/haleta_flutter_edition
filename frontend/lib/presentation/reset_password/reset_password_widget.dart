import 'package:flutter/material.dart';
import '../../application/auth/usecases/reset_password.dart';
import '../../infrastructure/auth/repositories/auth_repository_impl.dart';
import 'reset_password_controller.dart';

class ResetPasswordWidget extends StatefulWidget {
  final String username;
  final void Function() onSuccess;

  const ResetPasswordWidget({
    super.key,
    required this.username,
    required this.onSuccess,
  });

  @override
  _ResetPasswordWidgetState createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  late final ResetPasswordController controller;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    final repo = AuthRepositoryImpl();
    final useCase = ResetPasswordUseCase(repo);
    controller = ResetPasswordController(useCase, widget.username);
  }

  Future<void> _handleSubmit() async {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password.isEmpty) {
      _showMessage('Please enter a new password.');
      return;
    }

    if (password != confirmPassword) {
      _showMessage('Passwords do not match.');
      return;
    }

    setState(() => _isLoading = true);

    final success = await controller.resetPassword(password);

    setState(() => _isLoading = false);

    if (success) {
      _showMessage('Password reset successfully!');
      widget.onSuccess();
    } else {
      _showMessage('Failed to reset password. Please try again.');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "የይለፍ ቃል ይቀይሩ",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 40),
        TextField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            hintText: "አዲስ የይለፍ ቃል ያስገቡ",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          controller: _confirmPasswordController,
          obscureText: _obscureConfirmPassword,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(_obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
            hintText: "አዲስ የይለፍ ቃልዎን ያረጋግጡ",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        SizedBox(height: 30),
        _isLoading
            ? CircularProgressIndicator(color: Colors.white)
            : ElevatedButton(
                onPressed: _handleSubmit,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red[900],
                ),
                child: Text("ቀጥል"),
              ),
      ],
    );
  }
} 