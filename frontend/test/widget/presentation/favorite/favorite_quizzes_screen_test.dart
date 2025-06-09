import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'package:your_app_path/presentation/favorite/favorite_quiz_screen.dart';
import 'package:your_app_path/application/favorite/favorite_quiz_notifier.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  late MockFavoriteQuizNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockFavoriteQuizNotifier();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: ChangeNotifierProvider<FavoriteQuizNotifier>.value(
        value: mockNotifier,
        child: const FavoriteQuizzesScreen(),
      ),
    );
  }

  testWidgets('renders correctly and responds to input + buttons', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Type into the first text field
    final firstField = find.byType(TextField).at(0);
    await tester.enterText(firstField, 'quiz1');
    verify(mockNotifier.updateFirstQuizId('quiz1')).called(1);

    // Type into the second text field
    final secondField = find.byType(TextField).at(1);
    await tester.enterText(secondField, 'quiz2');
    verify(mockNotifier.updateSecondQuizId('quiz2')).called(1);

    // Tap "ተመልከት" button
    final viewButton = find.text('ተመልከት');
    await tester.tap(viewButton);
    verify(mockNotifier.onViewClicked()).called(1);

    // Tap "ቀጥል" button
    final continueButton = find.text('ቀጥል');
    await tester.tap(continueButton);
    verify(mockNotifier.onContinueClicked()).called(1);
  });
}
