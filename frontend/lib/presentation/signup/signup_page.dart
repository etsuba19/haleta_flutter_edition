import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/custom_button.dart';
import 'signup_controller.dart';
import 'signup_widgets.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(signupControllerProvider.notifier);

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Image.asset('assets/images/logoimg.jpg', height: 80),
            const SizedBox(height: 16),
            const Text('ለመመዝገብ', style: TextStyle(color: Colors.white, fontSize: 24)),
            const SizedBox(height: 20),

            // CustomInputField(
            //   hint: 'መለኪያ ስም',
            //   icon: Icons.email,
            //   // onChanged: controller.setEmail,
            // ),
            // const SizedBox(height: 10),

            CustomInputField(
              hint: 'እባል',
              icon: Icons.person,
              onChanged: controller.setUsername,
            ),
            const SizedBox(height: 10),

            CustomInputField(
              hint: 'የይለፍ ቃል',
              icon: Icons.vpn_key,
              obscureText: true,
              onChanged: controller.setPassword,
            ),
            const SizedBox(height: 20),

            CustomButton(
              text: 'ቀጥል',
              onPressed: () => GoRouter.of(context).go('/security-question'),
            ),
            const SizedBox(height: 20),

            const Text('ከዚህ በፊት ተመዝግበዋል?', style: TextStyle(color: Colors.white, fontSize: 18)),
            CustomButton(
              text: 'ይግቡ',
              onPressed: () => GoRouter.of(context).go('/signin'),
            ),
          ],
        ),
      ),
    );
  }
}
