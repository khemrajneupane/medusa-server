
FROM node:latest

# Install dependencies
RUN apt-get update && apt-get install -y bash

WORKDIR /app

# 1. First copy ONLY package files
COPY package.json yarn.lock ./

# 2. Install dependencies
RUN yarn install --frozen-lockfile

# 3. Copy all other files
COPY . .

# 4. Build the admin UI (critical step!)
RUN yarn build 

# Expose port (documentation only)
EXPOSE 9000

# 5. Start in production mode
CMD ["yarn", "start"]
