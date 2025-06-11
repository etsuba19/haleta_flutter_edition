import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:frontend/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Full App Integration Test', () {
    testWidgets('Complete user flow: Signup, Security Questions, Login, Home, Choice Navigation',
            (WidgetTester tester) async {
          app.main();
          await tester.pumpAndSettle();

          // START ON LOGIN PAGE
          expect(find.text('Login'), findsOneWidget);

          // TAP SIGNUP INSTEAD
          final signupButton = find.text('Don\'t have an account? Sign Up');
          await tester.tap(signupButton);
          await tester.pumpAndSettle();

          // SIGNUP PAGE
          expect(find.text('Sign Up'), findsOneWidget);
          await tester.enterText(find.byKey(const Key('signup_name_field')), 'Test User');
          await tester.enterText(find.byKey(const Key('signup_email_field')), 'test@example.com');
          await tester.enterText(find.byKey(const Key('signup_password_field')), 'test123');
          await tester.tap(find.byKey(const Key('signup_submit_button')));
          await tester.pumpAndSettle();

          // SECURITY QUESTIONS PAGE
          expect(find.text('Security Questions'), findsOneWidget);
          await tester.enterText(find.byKey(const Key('question_1_field')), 'Answer 1');
          await tester.enterText(find.byKey(const Key('question_2_field')), 'Answer 2');
          await tester.enterText(find.byKey(const Key('question_3_field')), 'Answer 3');
          await tester.tap(find.byKey(const Key('submit_security_answers_button')));
          await tester.pumpAndSettle();

          // REDIRECTED TO LOGIN PAGE
          expect(find.text('Login'), findsOneWidget);
          await tester.enterText(find.byKey(const Key('login_email_field')), 'test@example.com');
          await tester.enterText(find.byKey(const Key('login_password_field')), 'test123');
          await tester.tap(find.byKey(const Key('login_button')));
          await tester.pumpAndSettle();

          // HOME PAGE
          expect(find.text('Welcome'), findsOneWidget);

          // TAP CONTINUE TO CHOICE PAGE
          await tester.tap(find.byKey(const Key('continue_button')));
          await tester.pumpAndSettle();

          // CHOICE PAGE
          expect(find.text('Choose an Option'), findsOneWidget);

          // NAVIGATE TO QUIZ
          await tester.tap(find.byKey(const Key('go_to_quiz_button')));
          await tester.pumpAndSettle();
          expect(find.text('Quiz Page'), findsOneWidget);

          // GO BACK AND NAVIGATE TO RESOURCES
          await tester.pageBack();
          await tester.pumpAndSettle();
          await tester.tap(find.byKey(const Key('go_to_resources_button')));
          await tester.pumpAndSettle();
          expect(find.text('Resources Page'), findsOneWidget);
        });

    testWidgets('Forgot Password Flow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // TAP FORGOT PASSWORD
      await tester.tap(find.text('Forgot Password?'));
      await tester.pumpAndSettle();

      // FORGOT PASSWORD PAGE
      expect(find.text('Reset Password'), findsOneWidget);
      await tester.enterText(find.byKey(const Key('forgot_email_field')), 'test@example.com');
      await tester.tap(find.byKey(const Key('forgot_submit_button')));
      await tester.pumpAndSettle();

      // VERIFY SECURITY QUESTIONS APPEAR
      expect(find.text('Answer Your Security Questions'), findsOneWidget);
      await tester.enterText(find.byKey(const Key('forgot_question_1_field')), 'Answer 1');
      await tester.enterText(find.byKey(const Key('forgot_question_2_field')), 'Answer 2');
      await tester.enterText(find.byKey(const Key('forgot_question_3_field')), 'Answer 3');
      await tester.tap(find.byKey(const Key('verify_answers_button')));
      await tester.pumpAndSettle();

      // RESET PASSWORD
      await tester.enterText(find.byKey(const Key('new_password_field')), 'newpass123');
      await tester.tap(find.byKey(const Key('reset_password_button')));
      await tester.pumpAndSettle();

      // RETURN TO LOGIN
      expect(find.text('Login'), findsOneWidget);
    });
  });
}
