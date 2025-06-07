import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'login_view_model.dart';
import '../../widgets/custom_button.dart';
import 'package:go_router/go_router.dart'; // required for context.push


class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(loginViewModelProvider.notifier);
    // final role = ref.watch(loginViewModelProvider.select((state) => state)); // or simply vm.role if not using state
    // final state = ref.watch(loginViewModelProvider);
    // final vm = ref.read(loginViewModelProvider.notifier);

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
              // const SizedBox(height: 20),
              Image.asset('assets/images/logoimg.jpg', height: 80),
              const SizedBox(height: 16),
              const Text(
                'ለመግባት',
                style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),

              // Username
              _buildTextField(
                icon: Icons.person,
                hintText: 'ስም',
                onChanged: vm.setUsername,
              ),
              const SizedBox(height: 16),

              // Password
              _buildTextField(
                icon: Icons.vpn_key,
                hintText: 'የሚስጥር ቁጥር',
                obscureText: true,
                onChanged: vm.setPassword,
              ),

              const SizedBox(height: 16),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: 'student',
                        groupValue: vm.role,
                        onChanged: (value) => vm.setRole(value!),
                        fillColor: WidgetStateProperty.all(Color(0xFFF0DDE0)),
                      ),
                      const Text('ተማሪ', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'teacher',
                        groupValue: vm.role,
                        onChanged: (value) => vm.setRole(value!),
                        fillColor: WidgetStateProperty.all(Color(0xFFF0DDE0)),
                      ),
                      const Text('አስተማሪ', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),
              CustomButton(
                text: 'ግባ',
                onPressed: () {
                  GoRouter.of(context).go('/choice');
                },
              ),
              const SizedBox(height: 12),

              CustomButton(
                text: 'የሚስጥር ቁጥር ከረሱ',
                onPressed: () {},
                // backgroundColor: Colors.white,
                // textColor: Colors.red,
              ),

              const SizedBox(height: 24),
              const Text(
                'አካውንት የሎትም?',
                style: TextStyle(color: Color(0xFFF0DDE0)),
                
              ),
              const SizedBox(height: 8),
              CustomButton(
                text: 'ይመዝገቡ',
                onPressed: () {
                  GoRouter.of(context).go('/signup');

                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required IconData icon,
    required String hintText,
    bool obscureText = false,
    required Function(String) onChanged,
  }) {
    return TextField(
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black54),
        filled: true,
        fillColor: const Color(0xFFFFE6EC),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }
}
