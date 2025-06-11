@echo off
echo Setting Flutter and Dart environment variables for network issues...

:: Set proxy if needed
SET HTTP_PROXY=
SET HTTPS_PROXY=

:: Skip connectivity checks
SET FLUTTER_DOCTOR_NO_CONNECTIVITY=true

:: Enable offline pub get
SET PUB_HOSTED_URL=https://pub.flutter-io.cn
SET FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

:: Disable analytics
SET FLUTTER_SUPPRESS_ANALYTICS=true

echo Environment variables set. Now running flutter pub get in offline mode...
cd %~dp0
flutter pub get --offline

echo.
echo If successful, try building your app again.
echo If you still encounter issues, run: flutter build apk --debug --no-pub
echo.
pause 