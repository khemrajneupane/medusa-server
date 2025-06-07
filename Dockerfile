
FROM node:latest

# Set Node.js memory limit
ENV NODE_OPTIONS="--max-old-space-size=2048"

# Install git and build tools in a single layer, and clean up later
RUN apk add --no-cache \
  git \
  python3 \
  make \
  g++ \
  && mkdir /app

WORKDIR /app

COPY package*.json yarn.lock ./
RUN yarn install --production && yarn cache clean

# Remove build tools to reduce final image size
RUN apk del make g++ python3

# Copy the rest of the app
COPY . .
RUN yarn build
# Expose Medusa port
EXPOSE 9000

# Start the app
CMD ["yarn", "start"]
