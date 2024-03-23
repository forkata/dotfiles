echo 'Starting InfluxDB/Grafana docker container'
docker run --restart always \
  --ulimit nofile=66000:66000 \
  --name docker-statsd-influxdb-grafana \
  -p 1619:1619 \
  -p 3003:3003 \
  -p 3004:8888 \
  -p 8086:8086 \
  -p 8125:8125/udp \
  -v ~/influxdb:/var/lib/influxdb \
  -v ~/grafana:/var/lib/grafana \
  -e TZ='America/Vancouver' \
  -d \
  samuelebistoletti/docker-statsd-influxdb-grafana:latest
