const jwt = require('jsonwebtoken');
const config = require('../config/config');
const User = require('../models/user.model');
const { ApiError } = require('../utils/errorHandler');

// Protect routes - require user to be logged in
exports.protect = async (req, res, next) => {
  try {
    let token;
    
    // Check if token exists in headers
    if (req.headers.authorization && req.headers.authorization.startsWith('Bearer')) {
      token = req.headers.authorization.split(' ')[1];
    }
    
    // Check if token exists
    if (!token) {
      return res.status(401).json({
        success: false,
        message: 'Authentication required. Please log in to access this resource'
      });
    }
    
    try {
      // Verify token
      const decoded = jwt.verify(token, config.jwtSecret);
      
      // Check if user still exists
      const user = await User.findById(decoded.id);
      if (!user) {
        return res.status(401).json({
          success: false,
          message: 'The user belonging to this token no longer exists'
        });
      }
      
      // Set user in request
      req.user = user;
      next();
    } catch (error) {
      // Handle specific JWT errors
      if (error.name === 'JsonWebTokenError') {
        return res.status(401).json({
          success: false,
          message: 'Invalid token. Please log in again'
        });
      } else if (error.name === 'TokenExpiredError') {
        return res.status(401).json({
          success: false, 
          message: 'Your session has expired. Please log in again'
        });
      }
      
      // Handle other errors
      throw error;
    }
  } catch (error) {
    next(new ApiError('Authentication failed', 401));
  }
};

// Restrict to certain roles
exports.restrictTo = (...roles) => {
  return (req, res, next) => {
    if (!roles.includes(req.user.role)) {
      return res.status(403).json({
        success: false,
        message: 'You do not have permission to perform this action'
      });
    }
    next();
  };
}; 