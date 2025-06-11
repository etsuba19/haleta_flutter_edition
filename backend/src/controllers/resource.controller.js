const Resource = require('../models/resource.model');
const { ApiError } = require('../utils/errorHandler');

// Create a new resource
exports.createResource = async (req, res, next) => {
  try {
    // Only admin can create resources
    if (req.user.role !== 'admin') {
      return next(new ApiError('Only admins can create resources', 403));
    }
    
    // Add creator to resource data
    req.body.createdBy = req.user.id;
    
    const resource = await Resource.create(req.body);
    
    res.status(201).json({
      success: true,
      resource
    });
  } catch (error) {
    next(error);
  }
};

// Get all resources
exports.getAllResources = async (req, res, next) => {
  try {
    // Build query
    let query = {};
    
    // Filter by category
    if (req.query.category) {
      query.category = req.query.category;
    }
    
    // Filter by type
    if (req.query.type) {
      query.type = req.query.type;
    }
    
    // Filter by search term
    if (req.query.search) {
      query.$or = [
        { title: { $regex: req.query.search, $options: 'i' } },
        { description: { $regex: req.query.search, $options: 'i' } }
      ];
    }
    
    const resources = await Resource.find(query)
      .populate('createdBy', 'username')
      .sort({ createdAt: -1 });
    
    res.status(200).json({
      success: true,
      count: resources.length,
      resources
    });
  } catch (error) {
    next(error);
  }
};

// Get a single resource
exports.getResource = async (req, res, next) => {
  try {
    const resource = await Resource.findById(req.params.id)
      .populate('createdBy', 'username');
    
    if (!resource) {
      return next(new ApiError('Resource not found', 404));
    }
    
    res.status(200).json({
      success: true,
      resource
    });
  } catch (error) {
    next(error);
  }
};

// Update a resource
exports.updateResource = async (req, res, next) => {
  try {
    let resource = await Resource.findById(req.params.id);
    
    if (!resource) {
      return next(new ApiError('Resource not found', 404));
    }
    
    // Only admin can update resources
    if (req.user.role !== 'admin') {
      return next(new ApiError('Only admins can update resources', 403));
    }
    
    resource = await Resource.findByIdAndUpdate(req.params.id, req.body, {
      new: true,
      runValidators: true
    });
    
    res.status(200).json({
      success: true,
      resource
    });
  } catch (error) {
    next(error);
  }
};

// Delete a resource
exports.deleteResource = async (req, res, next) => {
  try {
    const resource = await Resource.findById(req.params.id);
    
    if (!resource) {
      return next(new ApiError('Resource not found', 404));
    }
    
    // Only admin can delete resources
    if (req.user.role !== 'admin') {
      return next(new ApiError('Only admins can delete resources', 403));
    }
    
    await resource.deleteOne();
    
    res.status(200).json({
      success: true,
      message: 'Resource deleted successfully'
    });
  } catch (error) {
    next(error);
  }
};

// Get resource categories
exports.getCategories = async (req, res, next) => {
  try {
    const categories = await Resource.distinct('category');
    
    res.status(200).json({
      success: true,
      categories
    });
  } catch (error) {
    next(error);
  }
}; 