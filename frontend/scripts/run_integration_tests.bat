@echo off
echo Starting Integration Tests...

echo.
echo Step 1: Clean previous builds
flutter clean

echo.
echo Step 2: Get dependencies
flutter pub get

echo.
echo Step 3: Running integration tests
echo Make sure your device/emulator is connected and running

echo.
echo Available commands:
echo - For connected device: flutter test integration_test/app_test.dart
echo - For specific device: flutter test integration_test/app_test.dart -d [device_id]

echo.
echo Running tests on default device...
flutter test integration_test/app_test.dart

echo.
echo Integration tests completed!
pause 