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

## Running the Tests

Simply run this command from the frontend directory:

```bash
flutter test integration_test/app_test.dart
```

Or use the provided scripts for a more automated experience.

## Quick Test Commands

```bash
# Navigate to frontend directory
cd frontend

# Clean and get dependencies
flutter clean && flutter pub get

# Run integration tests
flutter test integration_test/app_test.dart

# Run with verbose output for debugging
flutter test integration_test/app_test.dart --verbose
```

## Troubleshooting

If you get import errors:
1. Make sure you're in the `frontend` directory
2. Run `flutter clean && flutter pub get`
3. Ensure your device/emulator is connected: `flutter devices` 