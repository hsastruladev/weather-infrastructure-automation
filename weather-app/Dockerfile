# STAGE 1: Build Environment
# We use a Node image to "build" our weather app (if you had JS dependencies)
FROM node:20-alpine AS build
WORKDIR /app

# Copy your source code
COPY . .

# In a real React app, you'd run 'npm install && npm run build' here.
# Since we have a simple HTML file, we'll just ensure it exists.
RUN echo "" >> index.html

# STAGE 2: Production Environment (Nginx)
# We use Alpine Linux because it is tiny (~5MB) and more secure.
FROM nginx:alpine

# 1. Set metadata for the image
LABEL maintainer="hsastruladev"
LABEL version="1.0"
LABEL description="Secure Weather Dashboard with SSL and Nginx"

# 2. Create directory for SSL certificates
RUN mkdir -p /etc/nginx/ssl

# 3. Handle the "CI/CD Secrets" Paradox
# Create empty placeholder files so the build doesn't crash in GitHub Actions.
# The 'COPY' command will overwrite these ONLY if the real files exist locally.
RUN touch /etc/nginx/ssl/nginx-selfsigned.crt /etc/nginx/ssl/nginx-selfsigned.key

# 4. Copy configuration and assets
# Copy our custom Nginx config (where we set the Cache-Control headers)
COPY default.conf /etc/nginx/conf.d/default.conf

# Copy the static data and the built index.html
COPY weather.json /usr/share/nginx/html/
COPY --from=build /app/index.html /usr/share/nginx/html/

# 5. Copy SSL keys (using wildcards so it doesn't fail if they are missing in CI)
COPY *.crt *.key /etc/nginx/ssl/

# 6. Set permissions (Nginx needs to read these)
RUN chmod 644 /usr/share/nginx/html/weather.json

# 7. Expose ports (80 for redirect, 443 for SSL)
EXPOSE 80 443

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]