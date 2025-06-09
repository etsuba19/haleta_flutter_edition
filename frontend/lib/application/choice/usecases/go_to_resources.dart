import '../../../domain/choice/repositories/choice_repository.dart';

class GoToResources {
  final ChoiceRepository repository;

  GoToResources(this.repository);

  void call() {
    repository.goToResources();
  }
}
