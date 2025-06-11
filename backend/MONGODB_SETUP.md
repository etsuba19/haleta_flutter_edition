# MongoDB Setup Guide

## Option 1: Installing MongoDB Locally

1. Download and install MongoDB Community Server from [MongoDB Download Center](https://www.mongodb.com/try/download/community)
2. Follow the installation instructions for your operating system
3. Start MongoDB service:
   - Windows: MongoDB should be installed as a service and running automatically
   - macOS: `brew services start mongodb-community`
   - Linux: `sudo systemctl start mongod`
4. Verify MongoDB is running: `mongod --version`

## Option 2: Using MongoDB Atlas (Cloud Database)

1. Create a free MongoDB Atlas account at [MongoDB Atlas](https://www.mongodb.com/cloud/atlas/register)
2. Create a new project
3. Build a database (choose the free shared cluster)
4. Create a database user with password
5. Set up network access (IP access list) - you can allow access from anywhere for development
6. Get your connection string by clicking "Connect" > "Connect your application"
7. Create a `.env` file in your backend directory with the following content:

```
PORT=3000
MONGODB_URI=mongodb+srv://<username>:<password>@<cluster>.mongodb.net/haleta_db
JWT_SECRET=haleta_secure_secret_key
NODE_ENV=development
```

8. Replace `<username>`, `<password>`, and `<cluster>` with your actual MongoDB Atlas credentials

## Troubleshooting

If you're still having connection issues:

1. Check if you're using the correct connection string
2. Ensure your IP address is whitelisted in MongoDB Atlas Network Access
3. Verify that your username and password are correct
4. Try connecting using MongoDB Compass to test your connection string 