require('dotenv').config();

module.exports = {
  port: process.env.PORT || 3000,
  mongoUri: process.env.MONGODB_URI || 'mongodb+srv://ethub:5Z4XULUCaglfbizJ@cluster0.caiegf2.mongodb.net/haleta_db?retryWrites=true&w=majority&appName=Cluster0',
  jwtSecret: process.env.JWT_SECRET || 'haleta_app_secret_key',
  nodeEnv: process.env.NODE_ENV || 'development'
};