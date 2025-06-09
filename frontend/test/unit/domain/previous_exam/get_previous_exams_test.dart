import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:your_app_path/domain/previous_exam/get_previous_exam.dart';
import 'package:your_app_path/domain/previous_exam/previous_exam_repository.dart';

// Mock class
class MockPreviousExamRepository extends Mock implements PreviousExamRepository {}

void main() {
  late MockPreviousExamRepository mockRepository;
  late GetPreviousExam useCase;

  setUp(() {
    mockRepository = MockPreviousExamRepository();
    useCase = GetPreviousExam(mockRepository);
  });

  test('call() returns the repository instance', () {
    final result = useCase.call();

    expect(result, mockRepository);
  });
}
