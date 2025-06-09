class QuizState {
  final String question;
  final List<String> options;

  QuizState({
    this.question = '',
    List<String>? options,
  }) : options = options ?? ['', '', '', ''];

  QuizState copyWith({
    String? question,
    List<String>? options,
  }) {
    return QuizState(
      question: question ?? this.question,
      options: options ?? this.options,
    );
  }
}
