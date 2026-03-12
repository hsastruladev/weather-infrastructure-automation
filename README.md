[![Docker Build and Scan](https://github.com/hsastruladev/weather-infrastructure-automation/actions/workflows/docker-ci.yml/badge.svg)](https://github.com/hsastruladev/weather-infrastructure-automation/actions/workflows/docker-ci.yml)

🌦️ Weather Infrastructure Automation
A secure, containerized weather dashboard built with a DevSecOps-first approach. This project demonstrates automated CI/CD pipelines, Nginx SSL termination, and multi-stage Docker builds.

🚀 Features
Secure by Design: Nginx configured for HTTPS with automated SSL redirects and security headers (HSTS, X-Frame-Options).

CI/CD Pipeline: Fully automated GitHub Actions workflow for building, testing, and validating Docker images.

Optimized Images: Uses Multi-stage builds and Alpine Linux to ensure a minimal attack surface and small image size.

Infrastructure as Code: (If applicable) Terraform configurations for reproducible environment setup.

🛠️ Tech Stack
Containerization: Docker

Web Server: Nginx (Alpine-based)

CI/CD: GitHub Actions

Security: OpenSSL (Self-signed)

📦 Local Setup
To run this project locally, follow these steps to generate certificates and build the container.
1. Clone the repository
Bash
git clone https://github.com/hsastruladev/weather-infrastructure-automation.git
cd weather-infrastructure-automation/weather-app
2. Generate Local SSL Certificates
Since SSL keys are git-ignored for security, generate a local set for development:

Bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout nginx-selfsigned.key \
  -out nginx-selfsigned.crt \
  -subj "/C=US/ST=State/L=City/O=Dev/OU=DevOps/CN=localhost"
3. Build and Run
Bash
# Build the image
docker build -t weather-app .

# Run the container
docker run -d -p 80:80 -p 443:443 --name weather-dashboard weather-app
4. Access the App
Open https://localhost in your browser. (Note: Accept the self-signed certificate warning to proceed.)

⚙️ CI/CD Pipeline Logic
The included GitHub Action (docker-ci.yml) performs the following:

Context Injection: Creates base64-compliant dummy PEM headers to satisfy Docker build requirements without exposing real secrets.

Multi-Stage Build: Validates the Dockerfile logic.

Image Validation: Ensures the Nginx configuration is syntactically correct before completion.

📄 License
MIT License - feel free to use this for your own learning!
