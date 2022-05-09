# Mimir/Loki Demo

This sets up some homelab-y Mimir/Loki backends & collectors in Vagrant using docker-compose.

Uses weak/default passwords/configs and root+privileged containers,
Not suitable for production usage.

## "Quick" start

```
# Startup Vagrant (with a few disks to setup a test zfs pool for shiny metrics)
VAGRANT_EXPERIMENTAL=disks vagrant up
``

Head over to [Grafana](http://192.168.60.3:3000/grafana/d/pxB0sL6iz/system) (grafana/grafana) and cry in Chrome.
Some of the metrics will take some time to populate (e.g. Internet / DNS latency).

Other endpoints:
- http://192.168.60.3:3000/mimir/ (minir/mimir)
- http://192.168.60.3:3000/mimir/alertmanager/ (mimir/mimir)
- http://192.168.60.3:3000/minio/login (minioadmin/minioadmin)

## How to change passwords

This is what sucks when not using k8s & manifest rendering..

- monitoring-server/*.htpasswd
- monitoring-server/config/loki.yaml
- monitoring-server/config/mimir.yaml
- monitoring-server/config/grafana-datasources.yaml
- monitoring-client/config/prometheus.yaml
- monitoring-client/config/promtail.yaml

## Collection/Scrape interval

The interval is pre-configured to 5 seconds, and appears in three places:
- config/telegraf.config
- config/prometheus.yaml
- config/grafana-dashboards.yaml
