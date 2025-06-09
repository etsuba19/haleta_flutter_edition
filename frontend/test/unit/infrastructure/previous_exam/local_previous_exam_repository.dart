import 'package:untitled/domain/previous_exam/previous_exam_repository.dart';

import '../../domain/previous_exam/previous_exam.dart';

class LocalPreviousExamDataSource implements  PreviousExamRepository{
  final List<PreviousExam> _examStorage = [];

  void saveExam(PreviousExam exam) {
    _examStorage.add(exam);
  }

  List<PreviousExam> getAllExams() {
    return _examStorage;
  }

  PreviousExam? getExamById(String id) {
    return _examStorage.firstWhere(
          (e) => e.id == id,
      orElse: () => PreviousExam(id: ''),
    );
  }

  @override
  Future<void> continueExam(PreviousExam exam) {
    // TODO: implement continueExam
    throw UnimplementedError();
  }

  @override
  Future<void> viewExam(PreviousExam exam) {
    // TODO: implement viewExam
    throw UnimplementedError();
  }
}
