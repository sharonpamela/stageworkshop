#!/bin/bash

# Set the SSHPASS so we can run the sshpass command
export SSHPASS=techX2019!

# Script needed to push the CentOS_7_Cloud image
for i in `cat /root/GTS2019-APAC/gts2019_cluster_list_group2.txt | cut -d"|" -f 1`
do
	sshpass -e ssh -x -o StrictHostKeyChecking=no -o GlobalKnownHostsFile=/dev/null -o UserKnownHostsFile=/dev/null -q nutanix@$i '/usr/local/nutanix/bin/acli image.create CentOS_Cloud_7 image_type=kDiskImage wait=true container=Images source_url=http://10.42.8.50/images/CentOS-7-x86_64-GenericCloud.qcow2'
done


