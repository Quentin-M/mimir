#!/bin/bash
systemctl set-environment HOSTNAME=$(hostname)
systemctl set-environment DOCKER_GROUP=$(stat -c '%g' /var/run/docker.sock)
