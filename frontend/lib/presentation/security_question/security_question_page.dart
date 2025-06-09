import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'security_question_controller.dart';
import '../../widgets/custom_button.dart';
import 'question_input.dart';
import 'package:go_router/go_router.dart';

class SecurityQuestionPage extends ConsumerWidget {
  const SecurityQuestionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(securityQuestionControllerProvider.notifier);

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Image.asset('assets/images/logoimg.jpg', height: 80),
              const SizedBox(height: 16),
              const Text(
                'የይለፍ ቃል በረሱ ጊዜ አካውንት መልሰው ለማግኘት እነዚህን መረጃዎች ያስገቡ',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              QuestionInput(hint: 'ጥያቄ 1', onChanged: controller.setQuestion1),
              const SizedBox(height: 16),
              QuestionInput(hint: 'መልስ 1', onChanged: controller.setAnswer1),
              const SizedBox(height: 16),
              QuestionInput(hint: 'ጥያቄ 2', onChanged: controller.setQuestion2),
              const SizedBox(height: 16),
              QuestionInput(hint: 'መልስ 2', onChanged: controller.setAnswer2),

              const SizedBox(height: 20),
              CustomButton(
                text: 'ተመዝገብ',
                onPressed: () {
                  controller.submitAnswers();
                  GoRouter.of(context).go('/choice');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
