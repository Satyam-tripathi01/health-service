# Use an official Node.js runtime with Alpine Linux as a parent image
FROM node:20.12.1-alpine3.19

# Update package list and install necessary packages
RUN apk update && \
    apk add --no-cache git python3 py3-pip groff && \
    npm install -g typescript && \
    pip3 install --upgrade awscli --break-system-packages

# Set the working directory
WORKDIR /app

# Copy package.json and yarn.lock files to the working directory
COPY package*.json yarn.lock ./

# Install dependencies
RUN yarn install --frozen-lockfile

# Copy the rest of the application code
COPY . .

# Expose the port your app runs on
EXPOSE 3000

# Start the application
CMD ["yarn", "start"]
