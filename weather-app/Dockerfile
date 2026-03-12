# STAGE 1: Build/Preparation
FROM node:20-alpine AS build
WORKDIR /app
COPY . .
# Ensuring index.html exists for the final copy
RUN touch index.html

# STAGE 2: Production (Nginx)
FROM nginx:alpine

LABEL maintainer="hsastruladev"
LABEL description="Secure Weather Dashboard with SSL"

# 1. Setup SSL directory
RUN mkdir -p /etc/nginx/ssl

# 2. Copy SSL keys
# We use a wildcard (*) so it handles both .crt and .key in one layer.
# These are the files created by the GitHub Action (or your real local ones).
COPY nginx-selfsigned.* /etc/nginx/ssl/

# 3. Copy Nginx configuration
COPY default.conf /etc/nginx/conf.d/default.conf

# 4. Copy application assets
# We copy from the 'build' stage to keep the final image clean.
COPY weather.json /usr/share/nginx/html/
COPY --from=build /app/index.html /usr/share/nginx/html/

# 5. Set permissions and security
RUN chmod 644 /usr/share/nginx/html/weather.json
EXPOSE 80 443

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]