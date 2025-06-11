import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

// Corrected import: now imports PreviousExamPage (the actual class name)
import 'package:frontend/presentation/previous_exam/previous_exam_screen.dart'; // File path is correct
import 'package:frontend/application/previous_exam/previous_exam_notifier.dart';
import 'package:frontend/application/previous_exam/previous_exam_notifier.dart' as notifier;

// Mock class using mocktail
class MockPreviousExamNotifier extends Mock implements notifier.PreviousExamNotifier {}

void main() {
  late MockPreviousExamNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockPreviousExamNotifier();

    when(() => mockNotifier.uiState).thenReturn(
      notifier.PreviousExamState(firstQuizId: '', secondQuizId: ''),
    );

    // Register fallback values for method parameters if needed
    registerFallbackValue('');
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: ChangeNotifierProvider<notifier.PreviousExamNotifier>.value(
        value: mockNotifier,
        child: const PreviousExamPage(), // Corrected: Using PreviousExamPage
      ),
    );
  }

  testWidgets('renders correctly and interacts with notifier', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Find all TextFields (3)
    final textFields = find.byType(TextField);
    expect(textFields, findsNWidgets(3));

    // Interact with the first TextField (onFirstQuizIdChange)
    await tester.enterText(textFields.at(0), 'id1');
    verify(() => mockNotifier.onFirstQuizIdChange('id1')).called(1);

    // Interact with the third TextField (onSecondQuizIdChange)
    await tester.enterText(textFields.at(2), 'id2');
    verify(() => mockNotifier.onSecondQuizIdChange('id2')).called(1);

    // Tap View button
    await tester.tap(find.text('ተመልከት'));
    await tester.pump(); // Ensure any animations/events settle
    verify(() => mockNotifier.onViewClicked()).called(1);

    // Tap Continue button
    await tester.tap(find.text('ቀጥል'));
    await tester.pump();
    verify(() => mockNotifier.onContinueClicked()).called(1);
  });
}