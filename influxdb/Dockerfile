FROM phusion/baseimage:0.9.19
MAINTAINER Steven Schneider <stschn@microsoft.com>

RUN apt-get update &&\
    apt-get -y upgrade

RUN https://dl.influxdata.com/influxdb/releases/influxdb_1.3.6_amd64.deb
RUN dpkg -i influxdb_1.3.6_amd64.deb

RUN mkdir -p /opt/collectd/share/collectd
RUN curl -o /opt/collectd/share/collectd/types.db https://raw.githubusercontent.com/collectd/collectd/master/src/types.db

RUN apt-get update &&\
    apt-get install -y influxdb
    
ADD influxdb.conf /etc/influxdb/influxdb-template.conf
ADD types.db.mssql /opt/collectd/share/collectd/types.db.mssql

ENV INFLUXDB_DATA_DIRECTORY /host/influxdb
ENV INFLUXDB_META_DATA_DIRECTORY /host/influxdb
ENV INFLUXDB_WAL_DATA_DIRECTORY /host/influxdb
ENV INFLUXDB_HH_DATA_DIRECTORY /host/influxdb

ENV INFLUXDB_COLLECTD_LISTEN_PORT 25826

RUN mkdir -p /etc/service/influxdb
ADD run-influxdb.sh /etc/service/influxdb/run
RUN chmod +x /etc/service/influxdb/run

ENV HOME /root
CMD ["/sbin/my_init"]
