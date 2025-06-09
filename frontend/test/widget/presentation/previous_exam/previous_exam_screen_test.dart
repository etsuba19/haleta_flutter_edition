import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'package:your_app_path/presentation/previous_exam/previous_exam_screen.dart';
import 'package:your_app_path/application/previous_exam/previous_exam_notifier.dart';
import 'package:your_app_path/application/previous_exam/previous_exam_notifier.dart' as notifier;

import '../mocks/mocks.mocks.dart';

void main() {
  late MockPreviousExamNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockPreviousExamNotifier();
    when(mockNotifier.uiState).thenReturn(
      notifier.PreviousExamState(firstQuizId: '', secondQuizId: ''),
    );
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: ChangeNotifierProvider<notifier.PreviousExamNotifier>.value(
        value: mockNotifier,
        child: const PreviousExamPage(),
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
    verify(mockNotifier.onFirstQuizIdChange('id1')).called(1);

    // Interact with the third TextField (onSecondQuizIdChange)
    await tester.enterText(textFields.at(2), 'id2');
    verify(mockNotifier.onSecondQuizIdChange('id2')).called(1);

    // Tap View button
    await tester.tap(find.text('ተመልከት'));
    verify(mockNotifier.onViewClicked()).called(1);

    // Tap Continue button
    await tester.tap(find.text('ቀጥል'));
    verify(mockNotifier.onContinueClicked()).called(1);
  });
}
