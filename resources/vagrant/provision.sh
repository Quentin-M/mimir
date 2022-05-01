#!/bin/bash -ex

# Setup requirements
apt-get update
apt-get install -y zfsutils-linux docker-compose

# Setup docker configuration
echo '{"default-address-pools": [{"base": "172.17.0.0/16", "size": 24}], "log-driver": "journald"}' > /etc/docker/daemon.json
echo "export DOCKER_GROUP=$(stat -c '%g' /var/run/docker.sock)" >> /etc/environment
systemctl restart docker

# Setup basic firewall
cat /etc/docker/compose/mimir/resources/vagrant/ufw-docker.rules >> /etc/ufw/after.rules
for cidr in 192.168.0.0/16 10.0.0.0/8 172.16.0.0/12; do 
  ufw allow from 192.168.0.0/16 proto tcp to any port 22 comment "OpenSSH"
  ufw route allow proto tcp from any to any port 3000 comment "Grafana"
  #ufw route allow proto tcp from any to any port 3001 comment "Prometheus"
  #ufw route allow proto tcp from any to any port 3002 comment "Minio - Console"
  #ufw route allow proto tcp from any to any port 3003 comment "Mimir - Load Balancer"
done
ufw allow proto tcp from 172.17.0.0/16 to 172.17.0.0/24 port 3004 comment "Prometheus -> Telegraf"

ufw reload
ufw enable

# Setup test zfs pool
zpool create data mirror /dev/sdc /dev/sdd
zfs set mountpoint=/data data
zpool add data cache /dev/sde

# Start
echo "Starting.. (this will take a few minutes..)"
ln -s /etc/docker/compose/mimir/resources/vagrant/docker-compose@.service /etc/systemd/system/docker-compose@.service
systemctl daemon-reload
systemctl enable docker-compose@mimir --now

# Wait for Grafana
echo "Waiting for Grafana.."
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost:3000)" != "200" ]]; do
  echo -n "."
  sleep 5
done
echo " OK!"

