# Use a Node.js base image
FROM node:18-slim as build

# Set working directory
WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the Vite application for production
RUN npm run build

# Use a lightweight Nginx image to serve the build
FROM nginx:alpine

# Copy the build output from the build stage to Nginx's default public folder
COPY --from=build /app/dist /usr/share/nginx/html

# Expose the port that Nginx will listen on
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

