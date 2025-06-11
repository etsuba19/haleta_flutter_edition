const mongoose = require('mongoose');

const resourceSchema = new mongoose.Schema({
  title: {
    type: String,
    required: [true, 'Resource title is required'],
    trim: true
  },
  description: {
    type: String,
    required: [true, 'Resource description is required'],
    trim: true
  },
  url: {
    type: String,
    required: [true, 'Resource URL is required'],
    trim: true
  },
  category: {
    type: String,
    trim: true
  },
  type: {
    type: String,
    enum: ['article', 'video', 'audio', 'document', 'link', 'other'],
    default: 'article'
  },
  createdBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User'
  },
  createdAt: {
    type: Date,
    default: Date.now
  },
  updatedAt: {
    type: Date,
    default: Date.now
  }
});

// Update timestamp on update
resourceSchema.pre('findOneAndUpdate', function() {
  this.set({ updatedAt: Date.now() });
});

// Virtual for formatted date
resourceSchema.virtual('formattedDate').get(function() {
  return new Date(this.createdAt).toLocaleDateString();
});

// Configure toJSON
resourceSchema.set('toJSON', {
  virtuals: true,
  transform: function(doc, ret) {
    ret.id = ret._id;
    delete ret._id;
    delete ret.__v;
    return ret;
  }
});

const Resource = mongoose.model('Resource', resourceSchema);

module.exports = Resource;
