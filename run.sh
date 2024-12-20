#!/bin/sh

# Defaults if not set
: "${LOKI_USERNAME:=admin}"
: "${LOKI_PASSWORD:=admin}"
: "${GF_SECURITY_ADMIN_USER:=admin}"
: "${GF_SECURITY_ADMIN_PASSWORD:=admin}"

export GF_SECURITY_ADMIN_USER
export GF_SECURITY_ADMIN_PASSWORD

# Generate htpasswd file for Loki auth
htpasswd -b -c /etc/nginx/.htpasswd "$LOKI_USERNAME" "$LOKI_PASSWORD"

# Start Loki (target=all includes compactor, ingester, querier, etc.)
/usr/local/bin/loki-linux-amd64 --config.file=/etc/loki/config.yaml &

# Start Grafana
/usr/local/grafana/bin/grafana server --config=/usr/local/grafana/conf/custom.ini --homepath=/usr/local/grafana &

# Start Nginx
nginx -g 'daemon off;'
