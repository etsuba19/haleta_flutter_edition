# Backend Integration with Flutter Frontend

This document explains how the Flutter frontend integrates with the Node.js/Express backend.

## Architecture Overview

The integration follows a clean architecture approach:

1. **HTTP Client Layer**: Handles network requests using Dio
2. **Service Layer**: API-specific services for authentication, quizzes, resources
3. **Provider Layer**: Riverpod providers for state management
4. **Presentation Layer**: UI components that consume the providers

## Key Components

### HTTP Client

Located in `frontend/lib/infrastructure/core/network/http_client.dart`

- Handles all HTTP requests to the backend
- Manages authentication tokens
- Includes logging interceptors for debugging

### Authentication Service

Located in `frontend/lib/infrastructure/auth/auth_service.dart`

- Handles login, registration, and password reset
- Manages security questions for password recovery
- Provides user profile information

### Resource Service

Located in `frontend/lib/infrastructure/resources/resource_service.dart`

- Retrieves educational resources
- Allows admin users to create, update, and delete resources
- Provides category filtering

### Quiz Service

Located in `frontend/lib/infrastructure/quiz_list/quiz_service.dart`

- Manages quiz data and categories
- Allows admin users to create, update, and delete quizzes
- Handles quiz submissions

## State Management

The app uses Riverpod for state management:

- `authStateProvider`: Manages authentication state
- `quizzesProvider`: Provides access to quizzes
- `resourcesProvider`: Provides access to resources

## Data Persistence

User authentication state is persisted using SharedPreferences:

- Tokens are stored securely
- Sessions are restored when the app is restarted
- The app checks token validity on startup

## API Endpoints

The app communicates with these main API endpoints:

- `/api/auth/*`: Authentication endpoints
- `/api/quiz/*`: Quiz endpoints
- `/api/resources/*`: Resource endpoints

## Testing the Integration

1. Start the backend server:
   ```
   cd backend
   npm run dev
   ```

2. Run the Flutter app:
   ```
   cd frontend
   flutter run
   ```

3. Use the credentials from the seed data to test:
   - Admin: username `admin`, password `admin123`
   - Student: username `student`, password `student123`

## Configuration

The API base URL and other settings can be modified in:
`frontend/lib/infrastructure/core/config.dart` 