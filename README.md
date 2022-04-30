# Mimir

Uses weak/default passwords & configs,
Not suitable for production usage.

## "Quick" start

```
# Startup Vagrant
VAGRANT_EXPERIMENTAL=disks vagrant up

# Get inside the VM
vagrant ssh

# (Optional) Setup a ZFS pool
sudo apt update && sudo apt install -y zfsutils-linux
sudo zpool create data mirror /dev/sdc /dev/sdd
sudo zfs set mountpoint=/data data
sudo zpool add data cache /dev/sde

# Startup the mimir/telegraf/grafana/prometheus stack
sudo apt install -y docker-compose
cd /home/ubuntu/mimir
sudo TELEGRAF_GROUP=$(stat -c '%g' /var/run/docker.sock) docker-compose up
```

Head over to [Grafana](http://192.168.60.3:3000/d/pxB0sL6iz/system?orgId=1&refresh=1m) and cry in Chrome. Some of the metrics will take some time to populate (e.g. Internet / DNS latency).

## Ports

- Grafana: 3000 (host)
- Telegraf: 3001 (host)
- Prometheus: 3004 (host, disabled by default)
- Minio (console): 3002
- Mimir (lb): 3003

## Scrape interval

It appears in three places:
- telegraf (as the collection interval),
- prometheus
- grafana's datasource

## Grafana provisioning

Restarting Grafana is not enough to have it reload saved dashboards,
Must delete the container to clear the already provisioned data.

```
docker kill mimir_grafana_1 && docker rm mimir_grafana_1 && TELEGRAF_GROUP=$(stat -c '%g' /var/run/docker.sock) docker-compose up -d
```
## TODO
- Configure retention

