# Haleta Backend API

This is the backend API for the Haleta Flutter application, built with Express.js and MongoDB.

## Setup

1. Install dependencies:

```bash
npm install
```

2. Create a `.env` file in the root directory with the following variables:

```
PORT=3000
MONGODB_URI=mongodb://localhost:27017/haleta_db
JWT_SECRET=your_jwt_secret_key_here
NODE_ENV=development
```

## Running the Application

Start the development server:

```bash
npm run dev
```

Start the production server:

```bash
npm start
```

## Database Seeding

Seed the database with initial data:

```bash
npm run seed
```

This will create:
- Sample users (admin and student)
- Sample quizzes
- Sample resources

## Testing with Postman

A complete Postman collection is included for testing all API endpoints:

1. Import `postman_collection.json` and `postman_environment.json` into Postman
2. Select the "Haleta Backend Environment" from the environment dropdown
3. Start testing the endpoints in the suggested sequence

For detailed instructions, see the `POSTMAN_GUIDE.md` file.

## API Endpoints

### Authentication

- `POST /api/auth/register`: Register a new user
- `POST /api/auth/login`: Login user
- `GET /api/auth/me`: Get current user (protected)

#### Password Reset Flow
- `GET /api/auth/username-exists/:username`: Check if username exists
- `GET /api/auth/security-questions/:username`: Get security questions for username
- `POST /api/auth/verify-security-answers`: Verify security answers (returns reset token)
- `POST /api/auth/reset-password`: Reset password with new password
- `POST /api/auth/security-questions`: Set security questions (protected)

### Quizzes

- `GET /api/quiz`: Get all quizzes
- `GET /api/quiz/categories`: Get all quiz categories
- `GET /api/quiz/:id`: Get quiz by ID
- `POST /api/quiz`: Create a new quiz (protected)
- `PUT /api/quiz/:id`: Update a quiz (protected)
- `DELETE /api/quiz/:id`: Delete a quiz (protected)

### Resources

- `GET /api/resources`: Get all resources
- `GET /api/resources/categories`: Get all resource categories
- `GET /api/resources/:id`: Get resource by ID
- `POST /api/resources`: Create a new resource (protected)
- `PUT /api/resources/:id`: Update a resource (protected)
- `DELETE /api/resources/:id`: Delete a resource (protected)

## Authentication

This API uses JWT authentication. To access protected routes, include the token in the headers:

```
Authorization: Bearer <token>
```

### Password Reset Flow

The password reset flow follows these steps:

1. User provides username
2. Backend verifies username exists
3. User retrieves security questions for the username
4. User answers security questions
5. Backend verifies answers and returns a reset token
6. User sets a new password

### Security Questions

Users can define their own security questions and answers when registering or updating their profile. Each user must provide two security questions with corresponding answers. These questions are used for password recovery if the user forgets their password.

The security question format must include:
- Two questions (question1 and question2)
- An answer for each question

## Role-Based Access Control

The API supports two roles:
- `admin`: Full access to all endpoints. Admins manage the content (quizzes and resources) and serve as teachers in the system.
- `student`: Limited access to endpoints. Students can view content and take quizzes. 