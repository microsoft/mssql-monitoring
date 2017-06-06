# What is this project?

This is a project to get users started on monitoring Microsoft SQL Server on Linux using [collectd](https://collectd.org/), [InfluxDB](https://www.influxdata.com/) and [Grafana](https://grafana.com/).

# What do I need?

There are a few things that you will need bofore you can implement this monitoring environment.

- Access to docker.io and Github for pulling Docker images and this repository.
- A SQL machine or VM that you would like to monitor.
- 1-2 machines for running InfluxDB and Grafana, depending on how large your deployment is.
- InfluxDB opened ports: 25826 (inbound data to InfluxDB), 8086 (outbound queries from Grafana)
- Grafana opened port: 3000 (default web port for inbound connections)


# Setting up InfluxDb.

For sizing InfluxDB, refer to their [documentation](https://docs.influxdata.com/influxdb/v1.2/guides/hardware_sizing/#general-hardware-guidelines-for-a-single-node). Also note that it is also recommended that you provision SSD volumes for the InfluxDB data and wal directories. Not a requirement if you are doing a small (monitoring a few machines) scale setup.

- Install Docker Engine
  ```
  wget -qO- https://get.docker.com/ | sudo sh
  ```
- Clone this repository
  ```
  git clone https://github.com/Microsoft/mssql-monitoring.git
  ```
- Browse to ./mssql-monitoring/influxdb
- Edit run.sh and change the variables to match your environment
- Run run.sh. This will pull down the InfluxDB image and create and run the container
  ```
  sudo bash ./run.sh
  ```
  
# Setting up collectd on the Linux SQL Server you want to monitor

- Install Docker Engine
  ```
  wget -qO- https://get.docker.com/ | sudo sh
  ```
- Clone this repository
  ```
  git clone https://github.com/Microsoft/mssql-monitoring.git
  ```
- Browse to ./mssql-monitoring/collectd
- Edit run.sh and change the variables to match your environment
- Run run.sh. This will pull down the collectd image, set it to start on reboot and create and run the container.
  ```
  sudo bash ./run.sh
  ```

# Setting up Grafana

If you are doing a small (monitoring a few machines) scale setup, you should be fine running this on the same host as your InfluxDB container. We use the image created by [Grafana Labs](http://docs.grafana.org/installation/docker/) and we just added a run.sh file that you can use to run the container.

- Install Docker Engine
  ```
  wget -qO- https://get.docker.com/ | sudo sh
  ```
- If you are running this separately, you will need to clone this repository
  ```
  git clone https://github.com/Microsoft/mssql-monitoring.git
  ```
- Browse to ./mssql-monitoring/grafana
- Run run.sh. This will pull down the Grafana image and create and run the container
  ```
  sudo bash ./run.sh
  ```
- Browse to the URL where Grafana is running http://[MACHINE_IP]:3000
- Add your first data source
  * Name: influxdb
  * Type: InfluxDB
  * Url: http://[INFLUXDB_IP]:8086 (If you are running Grafana on the same host as InfluxDB, you will need to specify the public end point for your InfluxDB instance. Alternatively, you can edit the run.sh file to include /net=host and the default URL will work.)
  * Database: collectd_db
- Click Add
- Browse back to the main page and import the dashboards from the dashboard dropdown menu.
  Dashboards are located under [./sqlserver_perf_monitoring/grafana_dashboard_templates](https://github.com/Microsoft/mssql-monitoring/tree/master/grafana_dashboard_templates) in the GitHub repo.
  