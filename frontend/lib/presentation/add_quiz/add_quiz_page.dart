import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'add_quiz_controller.dart';

class AddQuizPage extends ConsumerWidget {
  const AddQuizPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(addQuizControllerProvider);
    final controller = ref.read(addQuizControllerProvider.notifier);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Question Bank',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF0DDE0),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Question TextField
                TextFormField(
                  key: ValueKey(quizState.question), // Important to update UI on clear
                  initialValue: quizState.question,
                  onChanged: controller.setQuestion,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Color(0xFF460C16)),
                  decoration: InputDecoration(
                    hintText: '+ Add Question',
                    hintStyle: const TextStyle(color: Color(0xFF460C16)),
                    filled: true,
                    fillColor: const Color(0xFFF0DDE0),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Option TextFields
                for (int i = 0; i < 4; i++) ...[
                  _QuizTextField(
                    key: ValueKey('${quizState.options[i]}-$i'), // Force rebuild
                    hint: '+ Option',
                    initialValue: quizState.options[i],
                    onChanged: (val) => controller.setOption(i, val),
                  ),
                  const SizedBox(height: 20),
                ],

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: _roundedButtonStyle(),
                        onPressed: () => controller.clear(),
                        child: const SizedBox(
                          width: 70,
                          child: Center(
                            child: Text('Cancel', textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: _roundedButtonStyle(),
                        onPressed: () => controller.save(),
                        child: const SizedBox(
                          width: 70,
                          child: Center(
                            child: Text('Save', textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ButtonStyle _roundedButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFF0DDE0),
      foregroundColor: const Color(0xFF460C16),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

class _QuizTextField extends StatelessWidget {
  final String hint;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const _QuizTextField({
    super.key,
    required this.hint,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Color(0xFF460C16)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF460C16)),
        filled: true,
        fillColor: const Color(0xFFF0DDE0),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
