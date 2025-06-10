import 'package:flutter/material.dart';
import 'forgot_password_widget.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ForgotPasswordWidget(
            onSuccess: () {
              Navigator.pushNamed(context, '/resetPassword'); // Next step
            },
          ),
        ),
      ),
    );
  }
}
