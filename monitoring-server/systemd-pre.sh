#!/bin/bash
GRAFANA_DATA="/etc/docker/data/grafana"
GRAFANA_IMG=$(cat docker-compose.yml | grep "image: grafana/grafana" | cut -d':' -f2- | tr -d ' ')
GRAFANA_UID=$(docker run -i --rm --entrypoint=/usr/bin/id $GRAFANA_IMG -u)
mkdir -p "${GRAFANA_DATA}/etc-grafana" "${GRAFANA_DATA}/var-lib-grafana" && chown -R "${GRAFANA_UID}" "${GRAFANA_DATA}"

LOKI_DATA="/etc/docker/data/loki"
LOKI_IMG=$(cat docker-compose.yml | grep "image: grafana/loki" | cut -d':' -f2- | tr -d ' ')
LOKI_UID=$(docker run -i --rm --entrypoint=/usr/bin/id $LOKI_IMG -u)
mkdir -p "${LOKI_DATA}" && chown -R "${LOKI_UID}" "${LOKI_DATA}"

MINIO_DATA="/etc/docker/data/minio"
mkdir -p ${MINIO_DATA}/mimir-blocks ${MINIO_DATA}/mimir-ruler ${MINIO_DATA}/mimir-alertmanager ${MINIO_DATA}/loki  ${MINIO_DATA}/loki-ruler  
