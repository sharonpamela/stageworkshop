# SH-COLO Automation

## Overview

Rebuild AHV-2 cluster no more than 1 hour. 


## Foundation

- ssh to foundation VM ``10.132.128.10``
    - double check the environemnt you will foundation
        - confirm no one will use AHV-2
        - confirm ``~/foundation/config/ahv-2.conf`` are correct. (please refer last chapter)
    - run script to foundation your gears
        ```
        CLUSTER_NAME=AHV-2
        CLUSTER_CONFIG=ahv-2.config
        cd ~/foundation
        service foundation_service stop
        ./bin/foundation --nos=./nos/5.8.2.tar --cluster_name=${CLUSTER_NAME} config/${CLUSTER_CONFIG}
        ```

    - after foundation 
        ```
        CLUSTER_NAME=AHV-2
        CLUSTER_IP=10.132.129.37
        CLUSTER_DNS=10.132.129.40
        ncli user reset-password user-name=admin password='nx2Tech432!'
        ncli user add last-name=nutanix first-name=nutanix user-name=nutanix user-password='nutanix/4u' email-id=nutanix@nutanix.sh
        ncli user grant-cluster-admin-role user-name=nutanix
        ncli user grant-user-admin-role user-name=nutanix
        ncli cluster edit-info new-name=${CLUSTER_NAME} external-ip-address=${CLUSTER_IP}
        ncli cluster set-timezone timezone=Asia/Shanghai
        ncli cluster add-to-name-servers servers=${CLUSTER_DNS}
        echo -e 'nx2Tech432!\nnx2Tech432!' | sudo passwd nutanix
        ```

## Configuration

- download automation script
    ```
    wget -O stageworkshop-master.zip https://github.com/panlm/stageworkshop/archive/master.zip
    unzip stageworkshop-master.zip
    ```

- put default info to ``~/stageworkshop-master/clusters.txt``
    ```
    #cluster_ip|pe_password|mail_address
    10.132.129.37|nx2Tech432!|leiming.pan@nutanix.com
    ```

- start to configure, using the 5th workshop
    ```
    cd stageworkshop-master
    ./stage_workshop.sh -f ./clusters.txt -w 5
    ```

- see log on ``pe`` and ``pc``
    ```
    tail -f ~/calm.log
    ```
    
- finial configure
    ```
    ncli user reset-password user-name=admin password='nx2Tech432!'
    ncli user add last-name=nutanix first-name=nutanix user-name=nutanix user-password='nutanix/4u' email-id=nutanix@nutanix.sh
    ncli user grant-cluster-admin-role user-name=nutanix
    ncli user grant-user-admin-role user-name=nutanix
    echo -e 'nx2Tech432!\nnx2Tech432!' | sudo passwd nutanix
    ```

## Login

- Login PE ``https://10.132.129.37:9440``
- Login PC ``https://10.132.129.39:9440``


# Reference

## ahv-2.config

- default ahv-2 configure on foundation vm ``/home/nutanix/foundation/config/ahv-2.config``
    ```
    ipmi_user=ADMIN
    ipmi_password=ADMIN

    hypervisor_netmask=255.255.128.0
    hypervisor_gateway=10.132.128.4
    hypervisor_nameserver=10.132.71.40
    hypervisor_password=nutanix/4u
    svm_subnet_mask=255.255.128.0
    svm_default_gw=10.132.128.4

    hyp_type=kvm
    hyp_version=20170830.166

    10.132.129.33
        hypervisor_ip=10.132.129.25
        svm_ip=10.132.129.29
        node_position=A

    10.132.129.34
        hypervisor_ip=10.132.129.26
        svm_ip=10.132.129.30
        node_position=A

    10.132.129.35
        hypervisor_ip=10.132.129.27
        svm_ip=10.132.129.31
        node_position=B
    ```

## ahv-3.config

- default ahv-3 configure on foundation vm ``/home/nutanix/foundation/config/ahv-3.config``
    ```
    ipmi_user=ADMIN
    ipmi_password=ADMIN

    hypervisor_netmask=255.255.128.0
    hypervisor_gateway=10.132.128.4
    hypervisor_nameserver=10.132.71.40
    hypervisor_password=nutanix/4u
    svm_subnet_mask=255.255.128.0
    svm_default_gw=10.132.128.4

    hyp_type=kvm
    hyp_version=20170830.166

    10.132.130.33
    hypervisor_ip=10.132.130.25
    svm_ip=10.132.130.29
    node_position=A

    10.132.130.34
    hypervisor_ip=10.132.130.26
    svm_ip=10.132.130.30
    node_position=B

    10.132.130.35
    hypervisor_ip=10.132.130.27
    svm_ip=10.132.130.31
    node_position=C

    10.132.130.36
    hypervisor_ip=10.132.130.28
    svm_ip=10.132.130.32
    node_position=D
    ```
