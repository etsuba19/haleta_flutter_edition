import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/custom_button.dart';
import 'choice_view_model.dart';

class ChoiceScreen extends ConsumerWidget {
  const ChoiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(choiceViewModelProvider);

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
            Image.asset('assets/images/logoimg.jpg', height: 250),
            const SizedBox(height: 40),
            CustomButton(
              text: 'ፈተና',
              onPressed: () => viewModel.onQuizSelected(context),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'ጥናት',
              onPressed: viewModel.onResourceSelected,
            ),
          ],
        ),
      ),
    );
  }
}
