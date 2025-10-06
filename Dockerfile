# Use a lightweight Node.js image
FROM node:18-alpine

#set working directory
WORKDIR /app

# Copy package files first and install dependencies
COPY package* .json ./
RUN npm install

# Copy the rest of the node
COPY . .

# Expose port 3000
EXPOSE 3000

# Start the app
CMD ["node", "app.js"]
