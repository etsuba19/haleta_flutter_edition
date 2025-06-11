import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/application/previous_exam/view_previous_exam.dart';
import 'package:frontend/domain/previous_exam/previous_exam.dart';
import 'package:frontend/domain/previous_exam/previous_exam_repository.dart';

// Mock class
class MockPreviousExamRepository extends Mock implements PreviousExamRepository {}

void main() {
  group('ViewPreviousExam', () {
    late MockPreviousExamRepository mockRepository;
    late ViewPreviousExam useCase;

    setUp(() {
      mockRepository = MockPreviousExamRepository();
      useCase = ViewPreviousExam(mockRepository);
    });

    test('calls repository.viewExam with the correct exam', () async {
      final exam = PreviousExam(id: 'EX001');

      when(() => mockRepository.viewExam(exam)).thenAnswer((_) async => Future.value());

      await useCase.call(exam);

      verify(() => mockRepository.viewExam(exam)).called(1);
    });
  });
}


