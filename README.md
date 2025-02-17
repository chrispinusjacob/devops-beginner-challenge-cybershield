# DevOps Beginner Challenge: Automate a Web App Deployment

## Objective
Deploying a simple **Node.js (Express)** web application using **Docker** and set up a **CI/CD pipeline** using **GitHub Actions**, deploying to **Railway**.

---

## Project Overview
This project follows a DevOps workflow to containerize and automate the deployment of a simple Node.js web application. It includes:
- A basic Express.js app displaying **"Hello, DevOps!"**
- A **Dockerized** environment
- **CI/CD automation** using GitHub Actions
- Deployment to **Railway.app**
- An **Nginx reverse proxy** setup

---

## Steps to Set Up

### 1. Prerequisites
Ensure you have the following installed:
- **Git**
- **Docker**
- **GitHub CLI**
- **Railway CLI** ([Install Here](https://railway.app/cli))
- A **GitHub Repository** for the project

### 2. Create the Web Application
Create a simple Node.js app using Express.js:

```javascript
const express = require('express');
const app = express();
const PORT = process.env.PORT || 5000;

app.get('/', (req, res) => {
    res.send('Hello, DevOps!');
});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
```

Save this as `server.js` in your project directory.

### 3. Containerize the Application
Create a **Dockerfile**:

```dockerfile
# Use Node.js base image
FROM node:18-alpine

# Set the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json ./
RUN npm install

# Copy the application code
COPY . .

# Expose port 3000
EXPOSE 5000

# Start the application
CMD ["node", "server.js"]
```

### 4. Build & Test Locally
Run the following commands:

```sh
docker build -t my-node-app .
docker run -p 5000:5000 my-node-app
```

Visit `http://localhost:5000` to verify.

### 5. Push to Docker Hub or GHCR
Login and push the container image:

```sh
docker login
# Tag and push
docker tag my-node-app username/my-node-app
docker push username/my-node-app
```

### 6. Deploy to Railway
Initialize and deploy to Railway:

```sh
railway init
railway up
```

Follow Railway’s CLI prompts to set up and deploy.

### 7. Set Up GitHub Actions CI/CD
Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to Railway
on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3
      
      - name: Install Railway CLI
        run: curl -fsSL https://railway.app/install.sh | sh
      
      - name: Deploy to Railway
        run: railway up
        env:
          RAILWAY_TOKEN: ${{ secrets.RAILWAY_TOKEN }}
```

Add **RAILWAY_TOKEN** as a GitHub secret.

### 8. Set Up Nginx Reverse Proxy (Bonus)
If hosting on a VM, create an Nginx config file:

```nginx
server {
    listen 80;
    server_name yourdomain.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

Reload Nginx:
```sh
sudo systemctl restart nginx
```

---

 

*GitHub Repository*:              https://github.com/chrispinusjacob/devops-beginner-challenge-cybershield
*Docker Hub/GHCR Repository*:     https://hub.docker.com/r/cjke/devops-beginner-challenge-cybershield
*Public Web App URL*:             https://devops-beginner-challenge.up.railway.app
*Reverse Proxy Configuration*:    https://devopschallenge.techgroupkenya.co.kes
