#!/bin/bash

cp /etc/influxdb/influxdb-template.conf /etc/influxdb/influxdb.conf
sed -i'' -e "s@##INFLUXDB_DATA_DIRECTORY##@${INFLUXDB_DATA_DIRECTORY}@" /etc/influxdb/influxdb.conf
sed -i'' -e "s@##INFLUXDB_META_DATA_DIRECTORY##@${INFLUXDB_META_DATA_DIRECTORY}@" /etc/influxdb/influxdb.conf
sed -i'' -e "s@##INFLUXDB_WAL_DATA_DIRECTORY##@${INFLUXDB_WAL_DATA_DIRECTORY}@" /etc/influxdb/influxdb.conf
sed -i'' -e "s@##INFLUXDB_HH_DATA_DIRECTORY##@${INFLUXDB_HH_DATA_DIRECTORY}@" /etc/influxdb/influxdb.conf
sed -i'' -e "s@##INFLUXDB_COLLECTD_LISTEN_PORT##@${INFLUXDB_COLLECTD_LISTEN_PORT}@" /etc/influxdb/influxdb.conf

influxd -config /etc/influxdb/influxdb.conf