#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
  yum -y update
  echo "Hello Washbrooks from user-data!"

# Create mount volume for logs
  sudo su - root
  # mkfs.ext4 /dev/sdf
  # mount -t ext4 /dev/sdf /var/log
  
# Install & Start nginx server
  yum search nginx 
  amazon-linux-extras install nginx1 -y
  systemctl start nginx
  systemctl enable nginx
  
# Print the hostname which includes instance details on nginx homepage  
  sudo echo Hello from `hostname -f` > /usr/share/nginx/html/index.html
