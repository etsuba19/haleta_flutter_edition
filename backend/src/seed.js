const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const config = require('./config/config');
const User = require('./models/user.model');
const Quiz = require('./models/quiz.model');
const Resource = require('./models/resource.model');

console.log('Attempting to connect to MongoDB with URI:', config.mongoUri);

// Connect to MongoDB with improved options
mongoose.connect(config.mongoUri, {
  serverSelectionTimeoutMS: 120000, // Increase timeout to 120 seconds
  socketTimeoutMS: 60000, // Socket timeout
  connectTimeoutMS: 60000, // Connection timeout
  useNewUrlParser: true,
  useUnifiedTopology: true
})
  .then(() => {
    console.log('MongoDB connected for seeding');
    seedData();
  })
  .catch(err => {
    console.error('MongoDB connection error details:', err);
    process.exit(1);
  });

// Clear existing data
const clearDB = async () => {
  try {
    console.log('Clearing User collection...');
    await User.deleteMany({});
    console.log('User collection cleared');
    
    console.log('Clearing Quiz collection...');
    await Quiz.deleteMany({});
    console.log('Quiz collection cleared');
    
    console.log('Clearing Resource collection...');
    await Resource.deleteMany({});
    console.log('Resource collection cleared');
    
    console.log('Database cleared successfully');
  } catch (error) {
    console.error('Error clearing database:', error);
    throw error;
  }
};

// Create users
const createUsers = async () => {
  try {
    console.log('Creating admin and student users...');
    const adminPassword = await bcrypt.hash('admin123', 10);
    const studentPassword = await bcrypt.hash('student123', 10);

    const admin = await User.create({
      username: 'admin',
      password: adminPassword,
      role: 'admin',
      securityQuestions: {
        question1: {
          question: 'ምሕላ: የልጅነት ቋሊ ሰፈርዎ ማን ነበር?',
          answer: 'addis ababa'
        },
        question2: {
          question: 'ምሕላ: የመጀመሪያ ትምህርት ቤት ማን ነበር?',
          answer: 'bole elementary'
        }
      }
    });

    const student = await User.create({
      username: 'student',
      password: studentPassword,
      role: 'student',
      securityQuestions: {
        question1: {
          question: 'ምሕላ: የልጅነት ቋሊ ሰፈርዎ ማን ነበር?',
          answer: 'bahir dar'
        },
        question2: {
          question: 'ምሕላ: የመጀመሪያ ትምህርት ቤት ማን ነበር?',
          answer: 'bahir dar elementary'
        }
      }
    });

    console.log('Users created successfully');
    return { admin, student };
  } catch (error) {
    console.error('Error creating users:', error);
    throw error;
  }
};

// Create quizzes
const createQuizzes = async (users) => {
  try {
    console.log('Creating quizzes...');
    const quizzes = [
      {
        title: 'የግእዝ ምሳሌያዊ ጥያቄዎች',
        description: 'ለጀማሪዎች የግእዝ ምሳሌያዊ ጥያቄዎች',
        difficulty: 'easy',
        category: 'Geez Basics',
        questions: [
          {
            questionText: 'እርሱ ብሎ ውእቱ ካለ እርሷ ብሎ ____',
            options: ['ውእቱ', 'ይቲ', 'አንቲ', 'ይእቲ'],
            correctAnswer: 'ይእቲ'
          },
          {
            questionText: 'ሀ፣ ሁ፣ ሂ፣ ሃ፣ ሄ፣ ህ፣ ሆ ማነው?',
            options: ['ግእዝ', 'ካእብ', 'ሣልስ', 'ራብዕ'],
            correctAnswer: 'ግእዝ'
          }
        ],
        createdBy: users.admin._id
      },
      {
        title: 'የግእዝ ጥያቄዎች - መካከለኛ ደረጃ',
        description: 'ለመካከለኛ ደረጃ ተማሪዎች የግእዝ ጥያቄዎች',
        difficulty: 'medium',
        category: 'Geez Grammar',
        questions: [
          {
            questionText: 'በግእዝ ስንት ፊደላት አሉ?',
            options: ['26', '33', '231', '182'],
            correctAnswer: '231'
          },
          {
            questionText: 'ግእዝ ከየት አገር ተነሳ?',
            options: ['ግሪክ', 'ግብጽ', 'ኢትዮጵያ', 'ሶርያ'],
            correctAnswer: 'ኢትዮጵያ'
          }
        ],
        createdBy: users.admin._id
      }
    ];

    await Quiz.insertMany(quizzes);
    console.log('Quizzes created successfully');
  } catch (error) {
    console.error('Error creating quizzes:', error);
    throw error;
  }
};

// Create resources
const createResources = async (users) => {
  try {
    console.log('Creating resources...');
    const resources = [
      {
        title: 'የግእዝ ፊደላት መማርያ',
        description: 'ለጀማሪዎች የግእዝ ፊደላት መማርያ',
        url: 'https://example.com/geez-alphabet',
        category: 'Learning Resources',
        type: 'document',
        createdBy: users.admin._id
      },
      {
        title: 'የግእዝ ዜማዎች',
        description: 'ልዝብ የግእዝ ዜማዎች',
        url: 'https://example.com/geez-music',
        category: 'Music',
        type: 'audio',
        createdBy: users.admin._id
      },
      {
        title: 'የግእዝ ቋንቋ ታሪክ',
        description: 'የግእዝ ቋንቋ ታሪክ',
        url: 'https://example.com/geez-history',
        category: 'History',
        type: 'article',
        createdBy: users.admin._id
      }
    ];

    await Resource.insertMany(resources);
    console.log('Resources created successfully');
  } catch (error) {
    console.error('Error creating resources:', error);
    throw error;
  }
};

// Seed data
const seedData = async () => {
  try {
    await clearDB();
    const users = await createUsers();
    await createQuizzes(users);
    await createResources(users);

    console.log('Database seeded successfully');
    mongoose.connection.close(); // Close connection when done
    process.exit(0);
  } catch (error) {
    console.error('Error seeding database:', error);
    mongoose.connection.close(); // Make sure to close connection on error
    process.exit(1);
  }
};

seedData(); 