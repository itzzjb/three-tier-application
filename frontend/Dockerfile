# Stage 1: Build
FROM node:lts AS builder
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Stage 2: Production
FROM node:lts-alpine AS production
WORKDIR /usr/src/app

# Copy the build artifacts from the builder stage
COPY --from=builder /usr/src/app /usr/src/app/
COPY package*.json ./

# Install production dependencies
RUN npm install --only=production

# Expose the port the app runs on
EXPOSE 3000

# Command to start the application
CMD ["npm", "start"]
