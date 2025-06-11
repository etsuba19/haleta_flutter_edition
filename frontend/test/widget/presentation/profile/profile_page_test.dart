import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'package:frontend/presentation/profile/profile_page.dart';
import 'package:frontend/application/profile/profile_notifier.dart';

class MockProfileNotifier extends Mock implements ProfileNotifier {}

void main() {
  late MockProfileNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockProfileNotifier();
  });

  Widget createWidgetUnderTest() {
    return ChangeNotifierProvider<ProfileNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: ProfileScreen(
          currentPage: "መለያ",
          onDrawerItemClick: (_) {},
          onBackClick: () {},
        ),
      ),
    );
  }

  testWidgets('ProfileScreen displays correctly and opens drawer', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Verify the menu icon is shown
    expect(find.byIcon(Icons.menu), findsOneWidget);

    // Tap the menu icon
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Verify drawer item is visible
    expect(find.text("ጥያቄ - ፈተና ክብደት"), findsOneWidget);

    // Tap the drawer item
    await tester.tap(find.text("ጥያቄ - ፈተና ክብደት"));
    await tester.pumpAndSettle();
    // No verification here — you can add a callback to test this

    // Tap outside the drawer to close it
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    // Tap the logout button
    await tester.tap(find.text("ከመለያ ውጣ"));
    await tester.pumpAndSettle();

    // No state or notifier call to verify logout by default
    // If your notifier handles logout, do:
    // verify(() => mockNotifier.logout()).called(1);
  });
}
