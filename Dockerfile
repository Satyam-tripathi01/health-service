# Use an official Node.js runtime with Alpine Linux as a parent image
FROM node:20.12.1-alpine3.19

# Update package list and install necessary packages
RUN apk update && \
    apk add --no-cache git python3 py3-pip groff && \
    npm install -g typescript && \
    pip3 install --upgrade awscli --break-system-packages

ENV AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
ENV AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION

# Set the working directory
WORKDIR /app

# Copy package.json and yarn.lock files to the working directory
COPY package*.json ./

# Check if yarn.lock exists and copy it
COPY yarn.lock ./

# Install dependencies
RUN yarn install --frozen-lockfile || yarn install

# Copy the rest of the application code
COPY . .

# Expose the port your app runs on
EXPOSE 3000

# Start the application
CMD ["/bin/sh", "-c", "yarn start"]
