import 'package:flutter_riverpod/flutter_riverpod.dart';

final securityQuestionViewModelProvider =
    StateNotifierProvider<SecurityQuestionViewModel, void>(
  (ref) => SecurityQuestionViewModel(),
);

class SecurityQuestionViewModel extends StateNotifier<void> {
  SecurityQuestionViewModel() : super(null);

  String question1 = '';
  String answer1 = '';
  String question2 = '';
  String answer2 = '';

  void setQuestion1(String value) => question1 = value;
  void setAnswer1(String value) => answer1 = value;
  void setQuestion2(String value) => question2 = value;
  void setAnswer2(String value) => answer2 = value;

  Future<void> submitAnswers() async {
    // print('Security Answers:\nQ1: $question1\nA1: $answer1\nQ2: $question2\nA2: $answer2');
    // Store or validate answers
  }
}
