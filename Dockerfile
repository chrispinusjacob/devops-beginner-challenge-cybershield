# Base image: Node.js v16 on Alpine Linux
FROM node:16-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package files to install dependencies
COPY package*.json ./

# Install production dependencies
RUN npm install --production

# Copy the application source code
COPY . .

# Expose port 5000 for the application
EXPOSE 5000

# Command to run the application
CMD ["npm", "start"]
