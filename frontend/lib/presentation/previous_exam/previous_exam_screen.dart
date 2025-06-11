import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/previous_exam/previous_exam_notifier.dart';
import 'previous_exam_widgets.dart';

class PreviousExamPage extends ConsumerWidget {
  const PreviousExamPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(previousExamNotifierProvider);
    final notifier = ref.read(previousExamNotifierProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          
          Positioned.fill(
            child: Image.asset(
              'assets/bg_img.jpg',
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    PreviousExamWidgets.headerLogo(),
                    PreviousExamWidgets.titleText('የፈተና ማህደር'),
                    const SizedBox(height: 70),

                    PreviousExamWidgets.quizTextField(
                      hintText: 'QuizID',
                      value: state.firstQuizId,
                      onChanged: notifier.onFirstQuizIdChange,
                    ),
                    const SizedBox(height: 30),
                    PreviousExamWidgets.quizTextField(
                      hintText: 'QuizID',
                      value: state.secondQuizId,
                      onChanged: notifier.onSecondQuizIdChange,
                    ),

                    const SizedBox(height: 100), // push buttons further down
                    PreviousExamWidgets.actionButtonsRow(
                      onViewPressed: notifier.onViewClicked,
                      onContinuePressed: notifier.onContinueClicked,
                    ),
                    const SizedBox(height: 40), // space after buttons
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
