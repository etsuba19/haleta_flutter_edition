import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'signup_view_model.dart';
import '../../widgets/custom_button.dart';
import 'package:go_router/go_router.dart'; // required for context.push



class SignupScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(signupViewModelProvider.notifier);

    return Scaffold(
      // backgroundColor: Colors.red.shade900,
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
            Text('ለመመዝገብ', style: TextStyle(color: Colors.white, fontSize: 24)),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFFADADA),
                hintText: 'መለኪያ ስም',
                hintStyle: TextStyle(fontWeight: FontWeight.bold),
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              textAlign: TextAlign.center,
              onChanged: viewModel.updateEmail,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFFADADA),
                hintText: 'እባል',
                hintStyle: TextStyle(fontWeight: FontWeight.bold),
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              textAlign: TextAlign.center,
              onChanged: viewModel.updateUsername,
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFFADADA),
                hintText: 'የይለፍ ቃል',
                hintStyle: TextStyle(fontWeight: FontWeight.bold),
                prefixIcon: Icon(Icons.vpn_key),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              textAlign: TextAlign.center,
              onChanged: viewModel.updatePassword,
            ),

            SizedBox(height: 20),
            CustomButton(
                text: 'ቀጥል',
                onPressed: () {
                  GoRouter.of(context).go('/security-question');
                },
                // backgroundColor: Colors.transparent,
                // textColor: Colors.white,
              ),
            SizedBox(height: 20),

            Text('ከዚህ በፊት ተመዝግበዋል?', style: TextStyle(color: Colors.white, fontSize: 18)),

            CustomButton(
                text: 'ይግቡ',
                onPressed: () {
                  GoRouter.of(context).go('/signin');
                },
                // backgroundColor: Colors.transparent,
                // textColor: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
