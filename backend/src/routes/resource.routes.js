const express = require('express');
const resourceController = require('../controllers/resource.controller');
const authMiddleware = require('../middleware/auth.middleware');

const router = express.Router();

// Public routes
router.get('/', resourceController.getAllResources);
router.get('/categories', resourceController.getCategories);
router.get('/:id', resourceController.getResource);

// Protected routes
router.use(authMiddleware.protect);

// Admin-only routes
router.post('/', resourceController.createResource);

router.route('/:id')
  .put(resourceController.updateResource)
  .delete(resourceController.deleteResource);

module.exports = router; 