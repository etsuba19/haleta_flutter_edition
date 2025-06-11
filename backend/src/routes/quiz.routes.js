const express = require('express');
const quizController = require('../controllers/quiz.controller');
const authMiddleware = require('../middleware/auth.middleware');

const router = express.Router();

// Public routes
router.get('/', quizController.getAllQuizzes);
router.get('/categories', quizController.getCategories);
router.get('/:id', quizController.getQuiz);

// Protected routes
router.use(authMiddleware.protect);

router.post('/', quizController.createQuiz);

router.route('/:id')
  .put(quizController.updateQuiz)
  .delete(quizController.deleteQuiz);

module.exports = router; 