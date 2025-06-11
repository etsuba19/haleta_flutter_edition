import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/application/previous_exam/previous_exam_notifier.dart';
import 'package:frontend/application/previous_exam/view_previous_exam.dart';
import 'package:frontend/application/previous_exam/continue_previous_exam.dart';
import 'package:frontend/domain/previous_exam/previous_exam.dart';

// Mock classes using mocktail
class MockViewPreviousExam extends Mock implements ViewPreviousExam {}
class MockContinuePreviousExam extends Mock implements ContinuePreviousExam {}

void main() {
  late PreviousExamNotifier notifier;
  late MockViewPreviousExam mockView;
  late MockContinuePreviousExam mockContinue;

  setUp(() {
    mockView = MockViewPreviousExam();
    mockContinue = MockContinuePreviousExam();
    notifier = PreviousExamNotifier(
      view: mockView,
      continueUseCase: mockContinue,
    );

    // Register fallback value for PreviousExam (if required)
    registerFallbackValue(PreviousExam(id: ''));
  });

  test('onFirstQuizIdChange updates state and notifies listeners', () {
    bool listenerCalled = false;
    notifier.addListener(() {
      listenerCalled = true;
    });

    notifier.onFirstQuizIdChange('abc123');

    expect(notifier.uiState.firstQuizId, 'abc123');
    expect(listenerCalled, true);
  });

  test('onSecondQuizIdChange updates state and notifies listeners', () {
    bool listenerCalled = false;
    notifier.addListener(() {
      listenerCalled = true;
    });

    notifier.onSecondQuizIdChange('xyz789');

    expect(notifier.uiState.secondQuizId, 'xyz789');
    expect(listenerCalled, true);
  });

  test('onViewClicked calls ViewPreviousExam with correct ID', () {
    notifier.onFirstQuizIdChange('test123');

    final expectedExam = PreviousExam(id: 'test123');
    when(() => mockView.call(expectedExam))
        .thenAnswer((_) async => Future.value());

    notifier.onViewClicked();

    verify(() => mockView.call(expectedExam)).called(1);
  });

  test('onContinueClicked calls ContinuePreviousExam with correct ID', () {
    notifier.onSecondQuizIdChange('test456');

    final expectedExam = PreviousExam(id: 'test456');
    when(() => mockContinue.call(expectedExam))
        .thenAnswer((_) async => Future.value());

    notifier.onContinueClicked();

    verify(() => mockContinue.call(expectedExam)).called(1);
  });
}
