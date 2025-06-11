import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'reset_password_widget.dart';

class ResetPasswordPage extends StatelessWidget {
  final String username;
  
  const ResetPasswordPage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ResetPasswordWidget(
            username: username,
            onSuccess: () {
              context.go('/login', extra: {'message': 'Password reset successfully. Please login with your new password.'});
            },
          ),
        ),
      ),
    );
  }
} 