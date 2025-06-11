const mongoose = require('mongoose');

const quizSchema = new mongoose.Schema({
  title: {
    type: String,
    required: [true, 'Quiz title is required'],
    trim: true
  },
  description: {
    type: String,
    trim: true
  },
  difficulty: {
    type: String,
    enum: ['easy', 'medium', 'hard'],
    default: 'medium'
  },
  category: {
    type: String,
    required: [true, 'Category is required'],
    trim: true
  },
  questions: [{
    questionText: {
      type: String,
      required: [true, 'Question text is required']
    },
    options: {
      type: [String],
      required: [true, 'Options are required'],
      validate: {
        validator: function(options) {
          return options.length >= 2; // At least 2 options
        },
        message: 'Quiz must have at least 2 options'
      }
    },
    correctAnswer: {
      type: String,
      required: [true, 'Correct answer is required'],
      validate: {
        validator: function(correctAnswer) {
          return this.options.includes(correctAnswer);
        },
        message: 'Correct answer must be one of the options'
      }
    }
  }],
  createdBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: [true, 'Quiz creator is required']
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
quizSchema.pre('findOneAndUpdate', function() {
  this.set({ updatedAt: Date.now() });
});

const Quiz = mongoose.model('Quiz', quizSchema);

module.exports = Quiz; 