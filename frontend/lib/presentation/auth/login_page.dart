import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'login_controller.dart';
import 'login_widgets.dart';
import '../../widgets/custom_button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(loginControllerProvider.notifier);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgimg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logoimg.jpg', height: 80),
              const SizedBox(height: 16),
              const Text('ለመግባት', style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 32),
              LoginInputField(icon: Icons.person, hintText: 'ስም', onChanged: vm.setUsername),
              const SizedBox(height: 16),
              LoginInputField(icon: Icons.vpn_key, hintText: 'የሚስጥር ቁጥር', obscureText: true, onChanged: vm.setPassword),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoleRadio(value: 'student', groupValue: vm.role, onChanged: vm.setRole),
                  RoleRadio(value: 'teacher', groupValue: vm.role, onChanged: vm.setRole),
                ],
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'ግባ',
                onPressed: () => GoRouter.of(context).go('/choice'),
              ),
              const SizedBox(height: 12),
              CustomButton(text: 'የሚስጥር ቁጥር ከረሱ', onPressed: () {}),
              const SizedBox(height: 24),
              const Text('አካውንት የሎትም?', style: TextStyle(color: Color(0xFFF0DDE0))),
              const SizedBox(height: 8),
              CustomButton(
                text: 'ይመዝገቡ',
                onPressed: () => GoRouter.of(context).go('/signup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
