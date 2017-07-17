#We use the grafana image that Grafana Labs provides http://docs.grafana.org/installation/docker/
# If you wish to modify the port that Grafana runs on, you can do that here.
sudo docker run -d -p 3000:3000 --name grafana grafana/grafana
