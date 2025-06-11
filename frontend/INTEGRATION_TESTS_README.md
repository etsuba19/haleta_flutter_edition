# Integration Tests Guide

This document explains how to run and maintain the integration tests for the Haleta Flutter app.

## Overview

The integration tests cover the complete user flows including:
- ✅ Home page navigation  
- ✅ User signup flow
- ✅ Login flow (student and admin)
- ✅ Navigation between main pages
- ✅ Forgot password flow
- ✅ Profile access

## Test Files Structure

```
frontend/
├── integration_test/
│   └── app_test.dart                 # Integration test driver
├── test/
│   └── integration/
│       └── full_app_test.dart        # Main integration tests
└── scripts/
    ├── run_integration_tests.bat     # Windows batch script
    └── run_integration_tests.ps1     # PowerShell script
```

## Prerequisites

1. **Flutter SDK** installed and added to PATH
2. **Connected device** or **running emulator**
3. **Backend server** running (if tests require real API calls)

### Check Connected Devices
```bash
flutter devices
```

### Start an Emulator
```bash
# List available emulators
flutter emulators

# Launch an emulator
flutter emulators --launch <emulator_name>
```

## Running Integration Tests

### Method 1: Using Scripts (Recommended)

**Windows (PowerShell):**
```powershell
cd frontend
.\scripts\run_integration_tests.ps1
```

**Windows (Command Prompt):**
```cmd
cd frontend
scripts\run_integration_tests.bat
```

### Method 2: Manual Commands

```bash
cd frontend

# Clean and prepare
flutter clean
flutter pub get

# Run integration tests
flutter test integration_test/app_test.dart

# Run with specific device
flutter test integration_test/app_test.dart -d <device_id>

# Run with verbose output
flutter test integration_test/app_test.dart --verbose
```

## Test Coverage

### 1. Complete User Flow Test
- ✅ Starts from home page
- ✅ Navigates to login
- ✅ Goes to signup
- ✅ Fills signup form
- ✅ Handles security questions
- ✅ Logs in with created account
- ✅ Navigates to quiz and study pages

### 2. Login Flow Test
- ✅ Tests admin and student login
- ✅ Validates role-based navigation
- ✅ Tests form validation

### 3. Forgot Password Test
- ✅ Tests forgot password flow
- ✅ Validates navigation to security questions

### 4. Navigation Test
- ✅ Tests profile page access
- ✅ Validates navigation between pages

## Test Keys Used

The integration tests use these test keys for reliable element finding:

| Component | Key | Location |
|-----------|-----|----------|
| Start Button | `start_button` | Home page |
| Login Username | `login_username_field` | Login page |
| Login Password | `login_password_field` | Login page |
| Login Button | `login_button` | Login page |
| Signup Button | `signup_button` | Login page |
| Signup Username | `signup_username_field` | Signup page |
| Signup Password | `signup_password_field` | Signup page |
| Continue Button | `signup_continue_button` | Signup page |

## Troubleshooting

### Common Issues

1. **No devices found**
   ```bash
   # Start an emulator
   flutter emulators --launch <emulator_name>
   
   # Or connect a physical device with USB debugging enabled
   ```

2. **Tests timeout**
   - Increase timeout in test configurations
   - Check if backend is running
   - Verify network connectivity

3. **Widget not found errors**
   - Check if UI text matches the test expectations
   - Verify test keys are properly set
   - Ensure proper wait times with `pumpAndSettle()`

4. **Backend connection issues**
   - Ensure backend server is running
   - Check API endpoints are accessible
   - Verify database connections

### Common Test Failures and Solutions

**Problem**: `TextField not found`
**Solution**: Check if the page has loaded completely, add more `pumpAndSettle()` calls

**Problem**: Navigation not working
**Solution**: Verify routes are properly configured in `app_router.dart`

**Problem**: Login fails
**Solution**: Check if test users exist in database or mock authentication

## Maintenance

### Adding New Tests

1. Add new test cases to `test/integration/full_app_test.dart`
2. Follow the existing pattern:
   ```dart
   testWidgets('New Test Description', (WidgetTester tester) async {
     await app.main();
     await tester.pumpAndSettle();
     
     // Test implementation
   });
   ```

### Adding Test Keys

1. Add keys to widgets:
   ```dart
   CustomButton(
     text: 'Button Text',
     key: const Key('button_test_key'),
     onPressed: () {},
   )
   ```

2. Use keys in tests:
   ```dart
   await tester.tap(find.byKey(const Key('button_test_key')));
   ```

### Updating Tests for UI Changes

1. Update expected text strings if UI text changes
2. Update test keys if widget structure changes
3. Update navigation flow if routes change

## Best Practices

1. **Use test keys** instead of finding by text when possible
2. **Add proper waits** with `pumpAndSettle()` after interactions
3. **Test realistic scenarios** with valid test data
4. **Keep tests isolated** - each test should be independent
5. **Use descriptive test names** that explain what is being tested
6. **Handle loading states** and async operations properly

## CI/CD Integration

To run integration tests in CI/CD pipelines:

```yaml
# Example GitHub Actions workflow
- name: Run Integration Tests
  run: |
    cd frontend
    flutter test integration_test/app_test.dart
```

## Performance

Integration tests can be slow. To optimize:

1. **Group related tests** to avoid repeated setup
2. **Use test data** that doesn't require complex backend operations
3. **Mock network calls** when possible
4. **Run critical path tests** first

---

For questions or issues with integration tests, check the existing test logs or contact the development team. 