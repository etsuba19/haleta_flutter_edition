import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'security_question_view_model.dart';
import '../../widgets/custom_button.dart';
import 'package:go_router/go_router.dart';

class SecurityQuestionScreen extends ConsumerWidget {

  const SecurityQuestionScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(securityQuestionViewModelProvider.notifier);

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
              Text(
                'የይለፍ ቃል በረሱ ጊዜ አካውንት መልሰው ለማግኘት እነዚህን መረጃዎች ያስገቡ',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              
              ),
              SizedBox(height: 20),
              
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFFADADA),
                  hintText: 'ጥያቄ 1',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: viewModel.setQuestion1,
              ),

              const SizedBox(height: 16),

              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFFADADA),
                  hintText: 'መልስ 1',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: viewModel.setAnswer1,
              ),
              
              const SizedBox(height: 16),

              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFFADADA),
                  hintText: 'ጥያቄ 2',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: viewModel.setQuestion2,
              ),

              const SizedBox(height: 16),
              
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFFADADA),
                  hintText: 'መልስ 2',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: viewModel.setAnswer2,
              ),
              
              SizedBox(height: 20),
              CustomButton(
                text: 'ተመዝገብ',
                onPressed: () {
                  GoRouter.of(context).go('/choice');
                },
                // backgroundColor: Colors.transparent,
                // textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
