# Mimir Demo

Uses weak/default passwords/configs and root+privileged containers,
Not suitable for production usage.

## "Quick" start

```
# Startup Vagrant (with a few disks to setup a test zfs pool for shiny metrics)
VAGRANT_EXPERIMENTAL=disks vagrant up
``

Head over to [Grafana](http://192.168.60.3:3000/d/pxB0sL6iz/system?orgId=1&refresh=1m) and cry in Chrome. Some of the metrics will take some time to populate (e.g. Internet / DNS latency).

## Other services

See resources/vagrant/provision.sh to open the ports to access the following services:
- [Prometheus](http://192.168.60.3:3001/targets)
- [Minio (console)](http://192.168.60.3:3002/)
- [Mimir (load balancer)](http://192.168.60.3:3003/)

## Collection/Scrape interval

It is pre-configured to 5 seconds, and appears in three places:
- config/telegraf.config
- config/prometheus.yaml
- config/grafana-dashboards.yaml

## TODO
- Configure retention

