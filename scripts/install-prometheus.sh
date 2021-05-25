#!/usr/bin/env bash
currentUser=chia
sudo mkdir -p /home/$currentUser/prometheus
sudo tee /home/$currentUser/prometheus/prometheus.yaml <<-'EOF'
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'Harvester'
    scrape_interval: 5s
    static_configs:
      - targets:
        - 10.0.10.10:9100
        - 10.0.10.12:9100
        - 10.0.10.13:9100
        - 10.0.10.14:9100
        - 10.0.10.15:9100
        - 10.0.10.16:9100
        - 10.0.10.17:9100
EOF

sudo docker pull prom/prometheus:latest
sudo docker run -d \
  -p 9090:9090 \
  -v ~/prometheus:/prometheus \
  -v ~/prometheus/database:/prometheus/database \
  --name prometheus \
  --network host \
  prom/prometheus:latest \
  --config.file=/prometheus/prometheus.yaml \
  --storage.tsdb.path=/prometheus/database \
  --storage.tsdb.retention.time=90d \