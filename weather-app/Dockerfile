# Stage 1: The "Heavy" Build
FROM node:18-alpine AS build
WORKDIR /app
# For now, we'll use a simple HTML file to test the plumbing
RUN echo "<h1>Weather App Live</h1><div id='data'></div><script>fetch('/weather.json').then(r=>r.json()).then(d=>{document.getElementById('data').innerText=d.city + ': ' + d.temperature})</script>" > index.html

# Stage 2: The "Tiny" Alpine Production
FROM nginx:alpine
COPY --from=build /app/index.html /usr/share/nginx/html/index.html
COPY weather.json /usr/share/nginx/html/weather.json
RUN mkdir -p /etc/nginx/ssl
COPY nginx-selfsigned.crt /etc/nginx/ssl/
COPY nginx-selfsigned.key /etc/nginx/ssl/
COPY default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80 443