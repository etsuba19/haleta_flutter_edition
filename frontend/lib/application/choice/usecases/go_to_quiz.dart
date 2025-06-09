import '../../../domain/choice/repositories/choice_repository.dart';

class GoToQuiz {
  final ChoiceRepository repository;

  GoToQuiz(this.repository);

  void call() {
    repository.goToQuiz();
  }
}
