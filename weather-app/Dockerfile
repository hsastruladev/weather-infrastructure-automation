# STAGE 1: Build Environment
FROM node:20-alpine AS build
WORKDIR /app
COPY . .
# Ensure the index file exists even if the build step is simple
RUN touch index.html

# STAGE 2: Production Environment (Nginx)
FROM nginx:alpine

LABEL maintainer="hsastruladev"
LABEL version="1.0"
LABEL description="Secure Weather Dashboard with SSL and Nginx"

# 1. Create SSL directory
RUN mkdir -p /etc/nginx/ssl

# 2. Copy SSL keys (Satisfied by the GitHub Action dummy files or your local real ones)
COPY nginx-selfsigned.* /etc/nginx/ssl/

# 3. Copy Nginx configuration
COPY default.conf /etc/nginx/conf.d/default.conf

# 4. Copy application assets from the build stage
COPY weather.json /usr/share/nginx/html/
COPY --from=build /app/index.html /usr/share/nginx/html/

# 5. Set permissions and expose ports
RUN chmod 644 /usr/share/nginx/html/weather.json
EXPOSE 80 443

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]