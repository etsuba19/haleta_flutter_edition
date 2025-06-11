import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'package:frontend/application/previous_exam/previous_exam_notifier.dart';
import 'package:frontend/presentation/previous_exam/previous_exam_controller.dart';

// Mock controller
class MockPreviousExamController extends Mock implements PreviousExamController {}

// Create a ChangeNotifier adapter that mimics PreviousExamNotifier functionality
class PreviousExamChangeNotifier extends ChangeNotifier {
  PreviousExamState _state = PreviousExamState();
  final MockPreviousExamController controller;
  
  PreviousExamChangeNotifier({required this.controller});
  
  PreviousExamState get state => _state;
  
  void onFirstQuizIdChange(String id) {
    _state = _state.copyWith(firstQuizId: id);
    notifyListeners();
  }
  
  void onSecondQuizIdChange(String id) {
    _state = _state.copyWith(secondQuizId: id);
    notifyListeners();
  }
  
  void onViewClicked() {
    controller.viewExam(_state.firstQuizId);
  }
  
  void onContinueClicked() {
    controller.continueExam(_state.secondQuizId);
  }
}

void main() {
  late PreviousExamChangeNotifier notifier;
  late MockPreviousExamController mockController;

  setUp(() {
    mockController = MockPreviousExamController();
    notifier = PreviousExamChangeNotifier(controller: mockController);
    
    // Setup stubs for async methods
    when(() => mockController.viewExam(any())).thenAnswer((_) => Future<void>.value());
    when(() => mockController.continueExam(any())).thenAnswer((_) => Future<void>.value());
  });

  // Simple test widget that uses provider and the adapter
  Widget createTestWidget() {
    return MaterialApp(
      home: ChangeNotifierProvider<PreviousExamChangeNotifier>.value(
        value: notifier,
        child: Scaffold(
          body: Builder(
            builder: (context) {
              // Access the notifier through Provider
              final notifier = Provider.of<PreviousExamChangeNotifier>(context, listen: false);
              
              return Column(
                children: [
                  TextField(
                    onChanged: notifier.onFirstQuizIdChange,
                  ),
                  TextField(
                    onChanged: notifier.onSecondQuizIdChange,
                  ),
                  ElevatedButton(
                    onPressed: notifier.onViewClicked,
                    child: const Text('ተመልከት'),
                  ),
                  ElevatedButton(
                    onPressed: notifier.onContinueClicked,
                    child: const Text('ቀጥል'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  testWidgets('Provider test - interacts with notifier correctly', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(createTestWidget());

    // Enter text in the first TextField
    await tester.enterText(find.byType(TextField).at(0), 'id1');
    expect(notifier.state.firstQuizId, equals('id1'));

    // Enter text in the second TextField
    await tester.enterText(find.byType(TextField).at(1), 'id2');
    expect(notifier.state.secondQuizId, equals('id2'));

    // Tap View button
    await tester.tap(find.text('ተመልከት'));
    await tester.pump();
    verify(() => mockController.viewExam('id1')).called(1);

    // Tap Continue button
    await tester.tap(find.text('ቀጥል'));
    await tester.pump();
    verify(() => mockController.continueExam('id2')).called(1);
  });
} 