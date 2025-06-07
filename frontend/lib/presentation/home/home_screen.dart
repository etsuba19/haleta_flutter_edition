import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_view_model.dart';
import '../../widgets/custom_button.dart';
// import '../login/login_screen.dart';
import 'package:go_router/go_router.dart'; // required for context.push


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isStarted = ref.watch(homeViewModelProvider);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgimg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logoimg.jpg', height: 300),
            const SizedBox(height: 20),
            const Text(
              'ይህ የግእዝ ጥያቄዎች ምታገኙበት የስልክ መተግበርያ ነው።',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFFFEE9CC), fontSize: 21, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'አስጀምር',
              onPressed: () {
                ref.read(homeViewModelProvider.notifier).start();
                // print('Navigating to login...');
                GoRouter.of(context).go('/login');

              },
            )

          ],
        ),
      ),
    );
  }
}
