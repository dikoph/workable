#!/bin/bash
sudo apt-get update
sudo apt-get install -y mongodb
sudo systemctl start mongodb
sudo systemctl enable mongodb
echo "replication:
replSetName: 'rs0'" | sudo tee -a /etc/mongod.conf
sudo systemctl restart mongodb

# Additional MongoDB configuration commands can go here