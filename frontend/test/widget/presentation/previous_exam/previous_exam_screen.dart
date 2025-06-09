import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/previous_exam/previous_exam_notifier.dart';

class PreviousExamPage extends StatelessWidget {
  const PreviousExamPage({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PreviousExamNotifier>();
    final uiState = viewModel.uiState;

    return Scaffold(
      body: Stack(
        children: [
          // ✅ Background image fully stretched
          Positioned.fill(
            child: Image.asset(
              'assets/bg_img.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // ✅ SafeArea + Scrollable content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Image.asset(
                      'assets/logoimg.jpg',
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
                      value: uiState.firstQuizId,
                      onChanged: viewModel.onFirstQuizIdChange,
                    ),
                    const SizedBox(height: 30),
                    _quizTextField(
                      hintText: 'QuizID',
                      value: uiState.firstQuizId,
                      onChanged: viewModel.onFirstQuizIdChange,
                    ),
                    const SizedBox(height: 30),
                    _quizTextField(
                      hintText: 'QuizID',
                      value: uiState.secondQuizId,
                      onChanged: viewModel.onSecondQuizIdChange,
                    ),

                    const SizedBox(height: 100), // push buttons further down
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


  Widget _quizTextField({
    required String hintText,
    required String value,
    required Function(String) onChanged,
  }) {
    return TextField(
      controller: TextEditingController(text: value),
      onChanged: onChanged,
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
