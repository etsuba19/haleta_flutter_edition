# Haleta Backend API Postman Collection Guide

This guide will help you test the Haleta Backend API using the provided Postman collection.

## Setup

1. Import the collection:
   - Open Postman
   - Click "Import" in the top left
   - Choose the `postman_collection.json` file from the backend directory
   - Click "Import"

2. Import the environment:
   - Click "Import" in Postman again
   - Choose the `postman_environment.json` file from the backend directory
   - Click "Import"
   - Select the "Haleta Backend Environment" from the environment dropdown in the top right

Alternatively, you can set up the environment manually:
   - Create a new environment in Postman (click "Environments" in the sidebar)
   - Add the following variables:
     - `baseUrl`: `http://localhost:3000` (or your server URL)
     - `adminToken`: leave empty (will be auto-filled when you login)
     - `studentToken`: leave empty (will be auto-filled when you login) 
     - `quizId`: leave empty (will be auto-filled when you create a quiz)
     - `resourceId`: leave empty (will be auto-filled when you create a resource)
     - `adminId`: leave empty (will be auto-filled when you login as admin)
     - `studentId`: leave empty (will be auto-filled when you login as student)
   - Save the environment and select it from the environment dropdown

## Using the Collection

The collection is organized into folders for each main API section:

### Testing Sequence

For complete testing, follow this sequence:

1. **Server Status**:
   - Run the "Root Endpoint" request to verify the server is running

2. **Authentication**:
   - Run "Login - Admin" using the credentials created in the seed data
   - Run "Login - Student" using the credentials created in the seed data
   - These logins will automatically store authentication tokens for later requests

3. **Quizzes**:
   - Run "Get All Quizzes" to see existing quizzes
   - Run "Create Quiz - Admin" to create a new quiz (stores quiz ID for later)
   - Run "Get Quiz by ID" to verify the quiz was created
   - Run "Update Quiz - Admin" to modify the quiz
   - Run "Create Quiz - Student" to verify that students cannot create quizzes
   - Run "Delete Quiz - Admin" to delete the quiz

4. **Resources**:
   - Follow similar steps as with quizzes to test resource creation, retrieval, updating, and deletion

5. **Password Reset Flow**:
   - Run "Check Username Exists" to verify a username
   - Run "Get Security Questions" to retrieve security questions
   - Run "Verify Security Answers" to verify answers and get reset token
   - Run "Reset Password" to change password
   - Try to "Login - Student" with the new password

## Pre-configured Test Scripts

The collection includes test scripts that automatically:
- Extract and store tokens from login responses
- Store IDs of created quizzes and resources for later use
- Validate successful responses

These scripts make it easier to run the full test suite without manual copying of values between requests.

## Troubleshooting

- **Authentication Errors**: Make sure your tokens are correctly stored in environment variables. You can see them by clicking on the environment quick look (eye icon).
  
- **Missing Resources**: Ensure you've run the seed script (`npm run seed`) to populate the database with initial data.

- **Request Failures**: Check the server logs for detailed error messages. The collection includes intentional failures (like student trying to create content) to verify access controls.

## Extending the Collection

You can duplicate and modify requests for additional testing:

- Change request bodies to test different inputs
- Add new test scripts to verify responses
- Create new requests for additional edge cases

Remember to use environment variables (`{{variableName}}`) instead of hardcoded values for reusable tests. 