import 'package:flutter_riverpod/flutter_riverpod.dart';

final securityQuestionControllerProvider =
    StateNotifierProvider<SecurityQuestionController, void>(
  (ref) => SecurityQuestionController(),
);

class SecurityQuestionController extends StateNotifier<void> {
  SecurityQuestionController() : super(null);

  String question1 = '';
  String answer1 = '';
  String question2 = '';
  String answer2 = '';

  void setQuestion1(String value) => question1 = value;
  void setAnswer1(String value) => answer1 = value;
  void setQuestion2(String value) => question2 = value;
  void setAnswer2(String value) => answer2 = value;

  void submitAnswers() {
    // Simulate saving or sending the answers
    print('Security Answers Submitted:\nQ1: $question1\nA1: $answer1\nQ2: $question2\nA2: $answer2');
  }
}
