
# Base image
FROM node:14-alpine

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React app
RUN npm run build

# Expose port 1001
EXPOSE 1001

# Set Traefik labels
LABEL "traefik.enable"="true"
LABEL "traefik.http.routers.scriptertechnology.rule"="Host(`scriptertechnology.com`)"
LABEL "traefik.http.routers.scriptertechnology.tls"="true"
LABEL "traefik.http.routers.scriptertechnology.tls.certresolver"="lets-encrypt"
LABEL "traefik.http.services.scriptertechnology.loadbalancer.server.port"="1001"

# Start the application
CMD ["npm", "start"]

