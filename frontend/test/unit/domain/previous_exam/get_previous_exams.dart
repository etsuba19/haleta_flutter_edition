import 'package:untitled/domain/previous_exam/previous_exam_repository.dart';

// import '../repositories/previous_exam_repository.dart';
import 'previous_exam.dart';

class GetPreviousExam {
  final PreviousExamRepository repository;

  GetPreviousExam(this.repository);

  PreviousExamRepository call() {
    return repository;
  }
}
