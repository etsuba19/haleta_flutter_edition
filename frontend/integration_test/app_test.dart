import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:frontend/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Tests', () {
    testWidgets('Basic app startup and navigation test', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Verify home page loads
      expect(find.text('ይህ የግእዝ ጥያቄዎች ምታገኙበት የስልክ መተግበርያ ነው።'), findsOneWidget);
      
      // Test navigation to login
      await tester.tap(find.byKey(const Key('start_button')));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify login page loads
      expect(find.text('ለመግባት'), findsOneWidget);
      
      // Test signup navigation
      await tester.tap(find.byKey(const Key('signup_button')));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify signup page loads
      expect(find.text('ለመመዝገብ'), findsOneWidget);
    });

    testWidgets('Login form test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to login
      await tester.tap(find.byKey(const Key('start_button')));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Test form input
      await tester.enterText(find.byKey(const Key('login_username_field')), 'testuser');
      await tester.enterText(find.byKey(const Key('login_password_field')), 'testpass');
      
      // Verify input was entered
      expect(find.text('testuser'), findsOneWidget);
      
      // Test login button is present and tappable
      expect(find.byKey(const Key('login_button')), findsOneWidget);
    });

    testWidgets('Signup form test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to signup
      await tester.tap(find.byKey(const Key('start_button')));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      
      await tester.tap(find.byKey(const Key('signup_button')));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Test signup form
      await tester.enterText(find.byKey(const Key('signup_username_field')), 'newuser');
      await tester.enterText(find.byKey(const Key('signup_password_field')), 'newpass123');
      
      // Verify input was entered
      expect(find.text('newuser'), findsOneWidget);
      
      // Test continue button is present
      expect(find.byKey(const Key('signup_continue_button')), findsOneWidget);
    });
  });
} 