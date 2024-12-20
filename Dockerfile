FROM alpine:3.18

# Install dependencies
RUN apk add --no-cache ca-certificates curl nginx apache2-utils su-exec

# Install Loki
ENV LOKI_VERSION="2.9.1"
RUN curl -fSL "https://github.com/grafana/loki/releases/download/v${LOKI_VERSION}/loki-linux-amd64.zip" -o /tmp/loki.zip \
  && apk add --no-cache unzip \
  && unzip /tmp/loki.zip -d /usr/local/bin \
  && chmod +x /usr/local/bin/loki-linux-amd64 \
  && rm /tmp/loki.zip

# Install Grafana
ENV GRAFANA_VERSION="10.1.4"
RUN curl -fSL "https://dl.grafana.com/oss/release/grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz" -o /tmp/grafana.tar.gz \
  && tar -zxvf /tmp/grafana.tar.gz -C /tmp \
  && mv /tmp/grafana-${GRAFANA_VERSION} /usr/local/grafana \
  && rm /tmp/grafana.tar.gz

# Copy configs
COPY loki-config.yaml /etc/loki/config.yaml
COPY grafana.ini /usr/local/grafana/conf/custom.ini
COPY nginx.conf /etc/nginx/nginx.conf
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Create all required directories for Loki and Grafana, including compactor working dir
RUN mkdir -p /data/loki/index /data/loki/boltdb-cache /data/loki/chunks /data/loki/compactor /data/grafana \
    && chmod -R 777 /data

EXPOSE 8080
CMD ["/run.sh"]
