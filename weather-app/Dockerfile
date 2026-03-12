# STAGE 1: Build Environment
FROM node:20-alpine AS build
WORKDIR /app
COPY . .
# Ensuring the index file exists for the build
RUN echo "" >> index.html

# STAGE 2: Production Environment (Nginx)
FROM nginx:alpine

LABEL maintainer="hsastruladev"
LABEL version="1.0"
LABEL description="Secure Weather Dashboard with SSL and Nginx"

# 1. Setup SSL directory and copy keys
# The GitHub Action creates 'dummy' keys so this line won't fail in CI/CD.
RUN mkdir -p /etc/nginx/ssl
COPY nginx-selfsigned.crt nginx-selfsigned.key /etc/nginx/ssl/

# 2. Copy Nginx configuration
COPY default.conf /etc/nginx/conf.d/default.conf

# 3. Copy application assets
COPY weather.json /usr/share/nginx/html/
COPY --from=build /app/index.html /usr/share/nginx/html/

# 4. Set permissions and expose ports
RUN chmod 644 /usr/share/nginx/html/weather.json
EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]