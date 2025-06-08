import 'package:flutter/material.dart';
import 'quiz_controller.dart';
import 'quiz_widgets.dart';

class QuizScreen extends StatefulWidget {
  final QuizViewModel viewModel;
  final VoidCallback onNextClick;

  const QuizScreen({Key? key, required this.viewModel, required this.onNextClick}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return QuizContent(
      viewModel: widget.viewModel,
      onNextClick: widget.onNextClick,
      onOptionSelected: (option) {
        setState(() {
          widget.viewModel.selectOption(option);
        });
      },
    );
  }
}
