# PowerShell script to fix Flutter network issues

Write-Host "Setting Flutter environment variables to bypass network checks..." -ForegroundColor Green

# Skip connectivity checks
$env:FLUTTER_DOCTOR_NO_CONNECTIVITY = "true"

# Use China mirror for pub packages
$env:PUB_HOSTED_URL = "https://pub.flutter-io.cn"
$env:FLUTTER_STORAGE_BASE_URL = "https://storage.flutter-io.cn"

# Disable analytics
$env:FLUTTER_SUPPRESS_ANALYTICS = "true"

# Add Windows firewall exceptions for Flutter
Write-Host "Adding Windows Firewall exceptions for Flutter and Dart..." -ForegroundColor Yellow
try {
    New-NetFirewallRule -DisplayName "Flutter" -Direction Outbound -Program "$env:USERPROFILE\flutter\bin\flutter.bat" -Action Allow -ErrorAction SilentlyContinue
    New-NetFirewallRule -DisplayName "Dart" -Direction Outbound -Program "$env:USERPROFILE\flutter\bin\cache\dart-sdk\bin\dart.exe" -Action Allow -ErrorAction SilentlyContinue
    Write-Host "Firewall rules added successfully." -ForegroundColor Green
} catch {
    Write-Host "Could not add firewall rules. You may need to run as Administrator." -ForegroundColor Red
}

# Run Flutter in offline mode
Write-Host "Attempting to run flutter pub get in offline mode..." -ForegroundColor Cyan
Set-Location $PSScriptRoot
& flutter pub get --offline

Write-Host ""
Write-Host "If successful, try building your app again with:" -ForegroundColor Green
Write-Host "flutter build apk --debug --no-pub" -ForegroundColor Cyan
Write-Host ""
Write-Host "If you still have issues, try running:" -ForegroundColor Yellow
Write-Host "flutter clean" -ForegroundColor Cyan
Write-Host "flutter pub cache repair" -ForegroundColor Cyan
Write-Host ""

Read-Host "Press Enter to exit" 