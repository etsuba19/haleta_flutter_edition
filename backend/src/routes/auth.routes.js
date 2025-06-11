const express = require('express');
const authController = require('../controllers/auth.controller');
const authMiddleware = require('../middleware/auth.middleware');

const router = express.Router();

// Public routes
// User registration
router.post('/register', authController.register);

// User login
router.post('/login', authController.login);

// Username existence check (for forgot password flow)
router.get('/username-exists/:username', authController.checkUsernameExists);

// Security questions operations for password reset
router.get('/security-questions/:username', authController.getSecurityQuestions);
router.post('/verify-security-answers', authController.verifySecurityAnswers);
router.post('/reset-password', authController.resetPassword);

// Protected routes - require authentication
router.use('/me', authMiddleware.protect);
router.get('/me', authController.getCurrentUser);

router.use('/security-questions', authMiddleware.protect);
router.post('/security-questions', authController.setSecurityQuestions);

module.exports = router; 