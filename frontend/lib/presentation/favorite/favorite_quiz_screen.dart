import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/favorite/favorite_quiz_notifier.dart';

class FavoriteQuizzesScreen extends StatelessWidget {
  const FavoriteQuizzesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FavoriteQuizNotifier>();
    final fieldBackground = const Color(0xFFFFF0F5);
    final buttonBackground = const Color(0xFFFFE4E1);

    return Scaffold(
      extendBodyBehindAppBar: true,       // This is correct and should remain
      // extendBodyBehindNavigationBar: true, // <--- THIS LINE HAS BEEN REMOVED TO FIX YOUR ERROR
      backgroundColor: Colors.transparent, // This is correct and should remain
      appBar: AppBar(
        backgroundColor: Colors.transparent, // This is correct and should remain
        elevation: 0, // This is correct and should remain
      ),
      body: Stack(
        children: [
          // Background image now truly fills the entire Scaffold body
          Positioned.fill(
            child: Image.asset(
              'assets/images/bgimg.jpg',
              fit: BoxFit.cover, // Ensures the image covers the entire area
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
                    const SizedBox(height: 20),
                    const Text(
                      'የተመረጡ ፈተናዎች',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 70),

                    TextField(
                      onChanged: viewModel.updateFirstQuizId,
                      decoration: InputDecoration(
                        hintText: 'QuizID',
                        filled: true,
                        fillColor: fieldBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintStyle: const TextStyle(color: Color(0xFF460C16)),
                      ),
                    ),
                    const SizedBox(height: 30),

                    TextField(
                      onChanged: viewModel.updateSecondQuizId,
                      decoration: InputDecoration(
                        hintText: 'QuizID',
                        filled: true,
                        fillColor: fieldBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintStyle: const TextStyle(color: Color(0xFF460C16)),
                      ),
                    ),
                    const SizedBox(height: 100),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: viewModel.onViewClicked,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: const Text(
                            'ተመልከት',
                            style: TextStyle(color: Color(0xFF741424)),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: viewModel.onContinueClicked,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
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