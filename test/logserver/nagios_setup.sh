#!/bin/bash

# Script for setting up the configuration files for the PE Cluster during the TechSummit 2019


# Get the list of the clusetrs to be created
for ip_name in `cat /root/scripts/pelist.txt`
do
	# Grab the IP address from the cluster
	pe_ip=`echo $ip_name | cut -d";" -f 2`
	
	# Grab the name of the cluster
	pe_name=`echo $ip_name | cut -d";" -f 1`

	# Copy the default file to the new, good hostname
	cp /usr/local/nagios/etc/servers/yourhost.cfg /usr/local/nagios/etc/servers/$pe_name.cfg 
	
	# Changing the original files to the right information
	# Set the right Servername
	sed -i "s/CLUSTER_NAME/$pe_name/g" /usr/local/nagios/etc/servers/$pe_name.cfg

	# Set the right IP address
	sed -i "s/CLUSTER_IP/$pe_ip/g" /usr/local/nagios/etc/servers/$pe_name.cfg
done

# Rename the temp file
mv /usr/local/nagios/etc/servers/yourhost.cfg /usr/local/nagios/etc/servers/yourhost.cfg.tmp

# Restart Nagios so it can start monitoring:
systemctl reload nagios.service
