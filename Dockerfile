
FROM node:latest

# Install dependencies (bash not needed in production)
RUN apk add --no-cache python3 make g++

WORKDIR /app

# 1. Copy only package files first for layer caching
COPY package.json yarn.lock ./

# 2. Install dependencies with frozen lockfile
RUN yarn install --frozen-lockfile --network-timeout 1000000

# 3. Copy all other files
COPY . .

# 4. Build production assets
RUN yarn build

# 5. Verify admin build exists
#RUN ls -la admin/dist/

EXPOSE 9000
CMD ["yarn", "start"]
