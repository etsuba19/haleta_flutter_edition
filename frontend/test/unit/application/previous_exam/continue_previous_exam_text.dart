import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/application/previous_exam/continue_previous_exam.dart';
import 'package:frontend/domain/previous_exam/previous_exam.dart';
import 'package:frontend/domain/previous_exam/previous_exam_repository.dart';

// Mock class using mocktail
class MockPreviousExamRepository extends Mock implements PreviousExamRepository {}

void main() {
  late MockPreviousExamRepository mockRepository;
  late ContinuePreviousExam useCase;

  setUp(() {
    mockRepository = MockPreviousExamRepository();
    useCase = ContinuePreviousExam(mockRepository);

    registerFallbackValue(PreviousExam(id: ''));
  });

  group('ContinuePreviousExam', () {
    test('calls repository.continueExam with the correct exam', () async {
      final exam = PreviousExam(id: '10'); // ✅ No title here

      when(() => mockRepository.continueExam(exam))
          .thenAnswer((_) async {});

      await useCase.call(exam);

      verify(() => mockRepository.continueExam(exam)).called(1);
    });
  });
}
