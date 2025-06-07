FROM node:18 

# Install build dependencies (Debian/Ubuntu packages)
RUN apt-get update && \
    apt-get install -y \
    python3 \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy package files first for better caching
COPY package.json yarn.lock ./

RUN yarn install

# Copy all other files
COPY . .

# Build production assets
RUN yarn build


EXPOSE 9000
CMD ["yarn", "start"]