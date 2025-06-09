import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:your_app_path/domain/previous_exam/previous_exam.dart';
import 'package:your_app_path/infrastructure/previous_exam/previous_exam_repository_impl.dart';
import 'package:your_app_path/infrastructure/previous_exam/local_previous_exam_repository.dart';

// Mock class for LocalPreviousExamDataSource
class MockLocalPreviousExamDataSource extends Mock implements LocalPreviousExamDataSource {}

void main() {
  late MockLocalPreviousExamDataSource mockDataSource;
  late PreviousExamRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockLocalPreviousExamDataSource();
    repository = PreviousExamRepositoryImpl(mockDataSource);
  });

  test('viewExam should call getExamById with correct ID', () async {
    final exam = PreviousExam(id: 'exam123');

    when(mockDataSource.getExamById(any)).thenReturn(exam);

    await repository.viewExam(exam);

    verify(mockDataSource.getExamById('exam123')).called(1);
  });

  test('continueExam should call getExamById with correct ID', () async {
    final exam = PreviousExam(id: 'exam456');

    when(mockDataSource.getExamById(any)).thenReturn(exam);

    await repository.continueExam(exam);

    verify(mockDataSource.getExamById('exam456')).called(1);
  });
}
