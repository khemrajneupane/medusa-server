
FROM node:latest

# Install bash (fixes env: can't execute 'bash' error)
RUN apt-get update && apt-get install -y bash

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json yarn.lock ./
RUN yarn install

# Copy the source code
COPY . .

# Expose Medusa port
EXPOSE 9000

# Default command (override in docker-compose)
CMD ["yarn", "start"]
