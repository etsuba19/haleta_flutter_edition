import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'admin_home_controller.dart';
import 'admin_home_widgets.dart';

class AdminHomePage extends ConsumerWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          SizedBox.expand(
            child: Image.asset(
              'assets/images/bgimg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Overlay content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),
                // Logo at top center
                Center(
                  child: Image.asset(
                    'assets/images/logoimg.jpg',
                    width: 250,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 40),
                // Menu Buttons
                Column(
                  children: [
                    MenuButton(
                      text: 'User List',
                      onTap: () {
                        ref
                            .read(adminHomeControllerProvider.notifier)
                            .navigateToUserList(context);
                      },
                    ),
                    const SizedBox(height: 20),
                    MenuButton(
                      text: 'Quizz List',
                      onTap: () {
                        ref
                            .read(adminHomeControllerProvider.notifier)
                            .navigateToQuizList(context);
                      },
                    ),
                    const SizedBox(height: 20),
                    MenuButton(
                      text: 'Resource List',
                      onTap: () {
                        ref
                            .read(adminHomeControllerProvider.notifier)
                            .navigateToResourceList(context);
                      },
                    ),
                    const SizedBox(height: 50),
                    MenuButton(
                      text: 'Logout',
                      onTap: () {
                        ref
                            .read(adminHomeControllerProvider.notifier)
                            .logout();
                      },
                      narrow: true,
                      short: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
