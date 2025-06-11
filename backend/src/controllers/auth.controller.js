const jwt = require('jsonwebtoken');
const User = require('../models/user.model');
const { ApiError } = require('../utils/errorHandler');
const config = require('../config/config');
const { validateSecurityQuestions } = require('../utils/security-questions');

// Generate JWT token
const generateToken = (id) => {
  return jwt.sign({ id }, config.jwtSecret, {
    expiresIn: '30d'
  });
};

// Register user
exports.register = async (req, res, next) => {
  try {
    const { username, password, role = 'student' } = req.body;

    // Validate role
    if (role && !['student', 'admin'].includes(role)) {
      return next(new ApiError('Invalid role. Role must be either student or admin', 400));
    }

    // Check if user already exists
    const userExists = await User.findOne({ username });
    if (userExists) {
      return next(new ApiError('User already exists', 400));
    }

    // Create user
    const user = await User.create({
      username,
      password,
      role
    });

    // Create token
    const token = generateToken(user._id);

    res.status(201).json({
      success: true,
      token,
      user: {
        id: user._id,
        username: user.username,
        role: user.role
      }
    });
  } catch (error) {
    next(error);
  }
};

// Login user
exports.login = async (req, res, next) => {
  try {
    const { username, password, role } = req.body;

    // Check if username and password exist
    if (!username || !password) {
      return next(new ApiError('Please provide username and password', 400));
    }

    // Check if user exists and password is correct
    const user = await User.findOne({ username }).select('+password');
    if (!user) {
      return next(new ApiError('Invalid credentials', 401));
    }

    // Verify role if provided
    if (role && user.role !== role) {
      return next(new ApiError('You do not have permission to login with this role', 403));
    }

    // Check password
    const isPasswordCorrect = await user.comparePassword(password);
    if (!isPasswordCorrect) {
      return next(new ApiError('Invalid credentials', 401));
    }

    // Create token
    const token = generateToken(user._id);

    res.status(200).json({
      success: true,
      token,
      user: {
        id: user._id,
        username: user.username,
        role: user.role
      }
    });
  } catch (error) {
    next(error);
  }
};

// Get current user
exports.getCurrentUser = async (req, res, next) => {
  try {
    const user = await User.findById(req.user._id);

    res.status(200).json({
      success: true,
      user: {
        id: user._id,
        username: user.username,
        role: user.role
      }
    });
  } catch (error) {
    next(error);
  }
};

// Check if username exists (for forgot password flow)
exports.checkUsernameExists = async (req, res, next) => {
  try {
    const { username } = req.params;

    const user = await User.findOne({ username });
    
    res.status(200).json({
      success: true,
      exists: !!user
    });
  } catch (error) {
    next(error);
  }
};

// Set security questions
exports.setSecurityQuestions = async (req, res, next) => {
  try {
    const { username, securityQuestions } = req.body;

    // Validate security questions format
    if (!validateSecurityQuestions(securityQuestions)) {
      return next(new ApiError('Security questions must include both questions and answers', 400));
    }

    // Check if user exists
    const user = await User.findOne({ username });
    if (!user) {
      return next(new ApiError('User not found', 404));
    }

    // Update security questions
    user.securityQuestions = securityQuestions;
    await user.save();

    res.status(200).json({
      success: true,
      message: 'Security questions set successfully'
    });
  } catch (error) {
    next(error);
  }
};

// Get security questions
exports.getSecurityQuestions = async (req, res, next) => {
  try {
    const { username } = req.params;

    // Check if user exists
    const user = await User.findOne({ username });
    if (!user) {
      return next(new ApiError('User not found', 404));
    }

    // Check if security questions exist
    if (!validateSecurityQuestions(user.securityQuestions)) {
      return next(new ApiError('Security questions not set for this user', 400));
    }

    // Return only the questions, not the answers
    res.status(200).json({
      success: true,
      questions: {
        [user.securityQuestions.question1.question]: '',
        [user.securityQuestions.question2.question]: ''
      }
    });
  } catch (error) {
    next(error);
  }
};

// Verify security answers
exports.verifySecurityAnswers = async (req, res, next) => {
  try {
    const { username, providedAnswers } = req.body;

    // Check if user exists
    const user = await User.findOne({ username });
    if (!user) {
      return next(new ApiError('User not found', 404));
    }

    // Check if security questions exist
    if (!validateSecurityQuestions(user.securityQuestions)) {
      return next(new ApiError('Security questions not set for this user', 400));
    }

    // Verify answers - normalize by converting to lowercase for case-insensitive comparison
    const question1 = user.securityQuestions.question1.question;
    const question2 = user.securityQuestions.question2.question;

    if (!providedAnswers[question1] || !providedAnswers[question2]) {
      return next(new ApiError('Answers must be provided for both questions', 400));
    }

    const isCorrect = providedAnswers[question1].toLowerCase() === user.securityQuestions.question1.answer.toLowerCase() &&
                      providedAnswers[question2].toLowerCase() === user.securityQuestions.question2.answer.toLowerCase();

    if (!isCorrect) {
      return next(new ApiError('Incorrect security answers', 400));
    }

    // Generate a temporary token for password reset
    const resetToken = generateToken(user._id);

    res.status(200).json({
      success: true,
      message: 'Security answers verified successfully',
      resetToken
    });
  } catch (error) {
    next(error);
  }
};

// Reset password
exports.resetPassword = async (req, res, next) => {
  try {
    const { username, newPassword } = req.body;

    if (!newPassword || newPassword.length < 6) {
      return next(new ApiError('Password must be at least 6 characters long', 400));
    }

    // Check if user exists
    const user = await User.findOne({ username });
    if (!user) {
      return next(new ApiError('User not found', 404));
    }

    // Update password
    user.password = newPassword;
    await user.save();

    res.status(200).json({
      success: true,
      message: 'Password reset successfully'
    });
  } catch (error) {
    next(error);
  }
}; 