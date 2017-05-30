#!//bin/bash

#unmount the local docker proc filesystem and mount the hosts proc filesystem
#allows collectd to collect metrics from the host
umount /proc
mount -o bind /host/proc /proc

cp /etc/collectd/collectd-template.conf /etc/collectd/collectd.conf
sed -i'' -e "s/##SQL_POLL_INTERVAL##/${SQL_POLL_INTERVAL}/" /etc/collectd/collectd.conf
sed -i'' -e "s/##SQL_HOSTNAME##/${SQL_HOSTNAME}/" /etc/collectd/collectd.conf
sed -i'' -e "s/##SQL_USERNAME##/${SQL_USERNAME}/" /etc/collectd/collectd.conf
sed -i'' -e "s/##SQL_PASSWORD##/${SQL_PASSWORD}/" /etc/collectd/collectd.conf
sed -i'' -e "s/##INFLUX_DB_SERVER##/${INFLUX_DB_SERVER}/" /etc/collectd/collectd.conf
sed -i'' -e "s/##INFLUX_DB_PORT##/${INFLUX_DB_PORT}/" /etc/collectd/collectd.conf

# Run collectd in foreground mode
/usr/sbin/collectd -C /etc/collectd/collectd.conf -f 
