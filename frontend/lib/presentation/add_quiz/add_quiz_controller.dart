import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../../domain/add_quiz/entities/quiz.dart';
import '../../../application/add_quiz/usecases/create_quiz.dart';
import '../../../infrastructure/add_quiz/datasources/add_quiz_remote_data_source.dart'; // ✅
import '../../../infrastructure/add_quiz/repositories_impl/add_quiz_repository_impl.dart';
import 'quiz_state.dart';

// ✅ Use case provider
final createQuizUseCaseProvider = Provider<CreateQuizUseCase>((ref) {
  final dio = Dio(); // You can configure Dio here if needed
  final remoteDataSource = AddQuizRemoteDataSourceImpl(dio); // ✅ Use the concrete implementation
  final repository = AddQuizRepositoryImpl(remoteDataSource);
  return CreateQuizUseCase(repository); // ✅ Use updated class name
});

// ✅ Controller: manages state and communicates with use case
class AddQuizController extends StateNotifier<QuizState> {
  final CreateQuizUseCase createQuizUseCase;

  AddQuizController(this.createQuizUseCase) : super(QuizState());

  // Update the quiz question
  void setQuestion(String question) {
    state = state.copyWith(question: question);
  }

  // Update one of the options by index
  void setOption(int index, String value) {
    if (index < 0 || index >= state.options.length) return;

    final updatedOptions = [...state.options];
    updatedOptions[index] = value;

    state = state.copyWith(options: updatedOptions);
  }

  // Reset the entire form
  void clear() {
    state = QuizState();
  }

  // Save the quiz using the use case
  Future<void> save() async {
    final quiz = Quiz(
      question: state.question.trim(),
      options: state.options.map((o) => o.trim()).toList(),
    );

    if (quiz.question.isEmpty || quiz.options.any((o) => o.isEmpty)) {
      print('❌ Validation failed: Question and all options must be filled.');
      return;
    }

    try {
      await createQuizUseCase(quiz);
      print('✅ Quiz saved successfully!');
      clear();
    } catch (e, st) {
      print('❌ Failed to save quiz: $e\n$st');
      // Optional: Update error state if needed for UI
    }
  }
}

// ✅ Provider to access the controller
final addQuizControllerProvider =
StateNotifierProvider<AddQuizController, QuizState>(
      (ref) => AddQuizController(ref.read(createQuizUseCaseProvider)),
);
