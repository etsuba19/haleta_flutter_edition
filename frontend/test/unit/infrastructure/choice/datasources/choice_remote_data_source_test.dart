// test/unit/infrastructure/choice/datasources/choice_remote_data_source_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/infrastructure/choice/datasources/choice_remote_data_source.dart';

void main() {
  group('ChoiceRemoteDataSource', () {
    testWidgets('navigateToQuiz calls Navigator.pushNamed with /quiz',
            (tester) async {
          final navigatorKey = GlobalKey<NavigatorState>();
          final dataSource = ChoiceRemoteDataSource(navigatorKey.currentContext!);

          // Setup test widget with navigator
          await tester.pumpWidget(MaterialApp(
            navigatorKey: navigatorKey,
            routes: {
              '/quiz': (context) => const Text('Quiz Page'),
            },
            home: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () => ChoiceRemoteDataSource(context).navigateToQuiz(),
                  child: const Text('Go to Quiz'),
                );
              },
            ),
          ));

          await tester.tap(find.text('Go to Quiz'));
          await tester.pumpAndSettle();

          expect(find.text('Quiz Page'), findsOneWidget);
        });
  });
}
