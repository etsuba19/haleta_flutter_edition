# Integration Test Runner for Flutter App

Write-Host "=== Flutter Integration Test Runner ===" -ForegroundColor Green

# Check if Flutter is installed
if (!(Get-Command flutter -ErrorAction SilentlyContinue)) {
    Write-Host "Error: Flutter is not installed or not in PATH" -ForegroundColor Red
    exit 1
}

# Clean previous builds
Write-Host "`n1. Cleaning previous builds..." -ForegroundColor Yellow
flutter clean

# Get dependencies
Write-Host "`n2. Getting dependencies..." -ForegroundColor Yellow
flutter pub get

# Check for connected devices
Write-Host "`n3. Checking for connected devices..." -ForegroundColor Yellow
$devices = flutter devices --machine | ConvertFrom-Json

if ($devices.Count -eq 0) {
    Write-Host "Error: No devices connected. Please connect a device or start an emulator." -ForegroundColor Red
    Write-Host "To start an emulator: flutter emulators --launch [emulator_name]" -ForegroundColor Cyan
    exit 1
} else {
    Write-Host "Found $($devices.Count) device(s):" -ForegroundColor Green
    foreach ($device in $devices) {
        Write-Host "  - $($device.name) ($($device.id))" -ForegroundColor Cyan
    }
}

# Run integration tests
Write-Host "`n4. Running integration tests..." -ForegroundColor Yellow
Write-Host "Test file: integration_test/app_test.dart" -ForegroundColor Cyan

try {
    flutter test integration_test/app_test.dart
    Write-Host "`n✅ Integration tests completed successfully!" -ForegroundColor Green
} catch {
    Write-Host "`n❌ Integration tests failed!" -ForegroundColor Red
    Write-Host "Error: $_" -ForegroundColor Red
    exit 1
}

Write-Host "`nTest run finished. Press any key to exit..." -ForegroundColor Yellow
Read-Host 