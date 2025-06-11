import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/previous_exam/previous_exam_notifier.dart';

class PreviousExamPage extends StatefulWidget {
  const PreviousExamPage({super.key});

  @override
  State<PreviousExamPage> createState() => _PreviousExamPageState();
}

class _PreviousExamPageState extends State<PreviousExamPage> {
  late TextEditingController _firstQuizIdController;
  late TextEditingController _secondQuizIdController;

  @override
  void initState() {
    super.initState();
    _firstQuizIdController = TextEditingController();
    _secondQuizIdController = TextEditingController();

    final viewModel = context.read<PreviousExamNotifier>();
    _firstQuizIdController.text = viewModel.uiState.firstQuizId;
    _secondQuizIdController.text = viewModel.uiState.secondQuizId;

    _firstQuizIdController.addListener(() {
      viewModel.onFirstQuizIdChange(_firstQuizIdController.text);
    });
    _secondQuizIdController.addListener(() {
      viewModel.onSecondQuizIdChange(_secondQuizIdController.text);
    });
  }

  @override
  void dispose() {
    _firstQuizIdController.dispose();
    _secondQuizIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PreviousExamNotifier>();
    final uiState = viewModel.uiState;

    return Scaffold(
      extendBodyBehindAppBar: true, // Extends body behind the AppBar
      backgroundColor: Colors.transparent, // Makes Scaffold background transparent
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Makes AppBar itself transparent
        elevation: 0, // Removes AppBar shadow
      ),
      body: Stack(
        children: [
          // Background image using correct path and covering full area
          Positioned.fill(
            child: Image.asset(
              'assets/images/bgimg.jpg', // Already correct path
              fit: BoxFit.cover, // Ensures it covers the entire area
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
                    // Logo image using correct path
                    Image.asset(
                      'assets/images/logoimg.jpg', // Already correct path
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
                    _quizTextField(
                      hintText: 'QuizID',
                      controller: _firstQuizIdController,
                    ),
                    const SizedBox(height: 30),
                    _quizTextField(
                      hintText: 'QuizID',
                      controller: _firstQuizIdController,
                    ),
                    const SizedBox(height: 30),
                    _quizTextField(
                      hintText: 'QuizID',
                      controller: _secondQuizIdController,
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
                          onPressed: viewModel.onViewClicked,
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
                          onPressed: viewModel.onContinueClicked,
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

  Widget _quizTextField({
    required String hintText,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: const Color(0xFFFFF0F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintStyle: const TextStyle(color: Color(0xFF460C16)),
      ),
    );
  }
}