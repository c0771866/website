# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory to /app
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install any needed packages
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Install MongoDB
RUN apt-get update && apt-get install -y mongodb

# Set the environment variable for the MongoDB data directory
ENV MONGO_DATA_DIR /data/db

# Create the MongoDB data directory
RUN mkdir -p ${MONGO_DATA_DIR}

# Expose the ports for the web server and MongoDB
EXPOSE 3000 27017

# Start MongoDB in the background
CMD ["mongod", "--dbpath", "${MONGO_DATA_DIR}", "--bind_ip_all", "--fork"]

# Start the web server
CMD ["npm", "start"]

