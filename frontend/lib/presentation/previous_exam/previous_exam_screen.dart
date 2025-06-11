import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/previous_exam/previous_exam_notifier.dart';
import 'previous_exam_widgets.dart';

class PreviousExamPage extends ConsumerStatefulWidget {
  const PreviousExamPage({super.key});

  @override
  ConsumerState<PreviousExamPage> createState() => _PreviousExamPageState();
}

class _PreviousExamPageState extends ConsumerState<PreviousExamPage> {
  late TextEditingController _firstQuizIdController;
  late TextEditingController _secondQuizIdController;

  @override
  void initState() {
    super.initState();
    _firstQuizIdController = TextEditingController();
    _secondQuizIdController = TextEditingController();
    
    // We'll set up the controllers in the build method since we need ref there
  }

  @override
  void dispose() {
    _firstQuizIdController.dispose();
    _secondQuizIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(previousExamNotifierProvider);
    final notifier = ref.read(previousExamNotifierProvider.notifier);

    // Update controllers with current state
    if (_firstQuizIdController.text != state.firstQuizId) {
      _firstQuizIdController.text = state.firstQuizId;
    }
    if (_secondQuizIdController.text != state.secondQuizId) {
      _secondQuizIdController.text = state.secondQuizId;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bgimg.jpg',
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
                    Image.asset(
                      'assets/images/logoimg.jpg',
                      height: 150,
                    ),
                    const Text(
                      'የፈተና ማህደር',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
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
                    const SizedBox(height: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFE4E1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: notifier.onViewClicked,
                          child: const Text(
                            'ተመልከት',
                            style: TextStyle(color: Color(0xFF741424)),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFE4E1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: notifier.onContinueClicked,
                          child: const Text(
                            'ቀጥል',
                            style: TextStyle(color: Color(0xFF741424)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
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