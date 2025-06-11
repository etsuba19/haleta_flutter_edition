const Quiz = require('../models/quiz.model');
const { ApiError } = require('../utils/errorHandler');

// Create a new quiz
exports.createQuiz = async (req, res, next) => {
  try {
    // Only admin can create quizzes
    if (req.user.role !== 'admin') {
      return next(new ApiError('Only admins can create quizzes', 403));
    }
    
    // Add creator to quiz data
    req.body.createdBy = req.user.id;
    
    const quiz = await Quiz.create(req.body);
    
    res.status(201).json({
      success: true,
      quiz
    });
  } catch (error) {
    next(error);
  }
};

// Get all quizzes
exports.getAllQuizzes = async (req, res, next) => {
  try {
    // Build query
    let query = {};
    
    // Filter by category
    if (req.query.category) {
      query.category = req.query.category;
    }
    
    // Filter by difficulty
    if (req.query.difficulty) {
      query.difficulty = req.query.difficulty;
    }
    
    // Filter by creator
    if (req.query.createdBy) {
      query.createdBy = req.query.createdBy;
    }
    
    const quizzes = await Quiz.find(query)
      .populate('createdBy', 'username')
      .sort({ createdAt: -1 });
    
    res.status(200).json({
      success: true,
      count: quizzes.length,
      quizzes
    });
  } catch (error) {
    next(error);
  }
};

// Get a single quiz
exports.getQuiz = async (req, res, next) => {
  try {
    const quiz = await Quiz.findById(req.params.id)
      .populate('createdBy', 'username');
    
    if (!quiz) {
      return next(new ApiError('Quiz not found', 404));
    }
    
    res.status(200).json({
      success: true,
      quiz
    });
  } catch (error) {
    next(error);
  }
};

// Update a quiz
exports.updateQuiz = async (req, res, next) => {
  try {
    let quiz = await Quiz.findById(req.params.id);
    
    if (!quiz) {
      return next(new ApiError('Quiz not found', 404));
    }
    
    // Only admin can update quizzes
    if (req.user.role !== 'admin') {
      return next(new ApiError('Only admins can update quizzes', 403));
    }
    
    quiz = await Quiz.findByIdAndUpdate(req.params.id, req.body, {
      new: true,
      runValidators: true
    });
    
    res.status(200).json({
      success: true,
      quiz
    });
  } catch (error) {
    next(error);
  }
};

// Delete a quiz
exports.deleteQuiz = async (req, res, next) => {
  try {
    const quiz = await Quiz.findById(req.params.id);
    
    if (!quiz) {
      return next(new ApiError('Quiz not found', 404));
    }
    
    // Only admin can delete quizzes
    if (req.user.role !== 'admin') {
      return next(new ApiError('Only admins can delete quizzes', 403));
    }
    
    await quiz.deleteOne();
    
    res.status(200).json({
      success: true,
      message: 'Quiz deleted successfully'
    });
  } catch (error) {
    next(error);
  }
};

// Get quiz categories
exports.getCategories = async (req, res, next) => {
  try {
    const categories = await Quiz.distinct('category');
    
    res.status(200).json({
      success: true,
      categories
    });
  } catch (error) {
    next(error);
  }
}; 