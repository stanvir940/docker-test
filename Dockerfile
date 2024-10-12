# # Use the official Nginx image from DockerHub
# FROM nginx:alpine

# # Copy the HTML file to the default Nginx directory
# COPY index.html /usr/share/nginx/html/

# # Expose port 80 for the web server
# EXPOSE 80

# Use a specific version of Ubuntu for consistency
# Use CentOS as the base image
# Use CentOS as the base image
FROM centos:latest

# Set a working mirror to bypass DNS issue
RUN sed -i 's|^mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|^#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# Update the package repository and install Nginx
RUN yum -y update && yum -y install epel-release && yum -y install nginx

# Remove default content in the web server directory
RUN rm -rf /usr/share/nginx/html/*

# Copy your custom index.html to the Nginx default directory
COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start Nginx in the foreground
ENTRYPOINT ["nginx", "-g", "daemon off;"]

