#!/usr/bin/env bash

# Run the needed variabkles
./global.vars.sh

# Test script to get the objects store creation
# Get the UUIDs of: 
# - UUID of the cluster
# - UUID of the network we need to have to get the command running. As we need to have them run in the primary network, we can use that UUID in the command

function object_store() {
    local _attempts=30
    local _loops=0
    local _sleep=60
    local CURL_HTTP_OPTS=' --max-time 25 --silent --header Content-Type:application/json --header Accept:application/json  --insecure '
    local _url_network='https://localhost:9440/api/nutanix/v3/subnets/list'
    local _url_oss='https://localhost:9440/oss/api/nutanix/v3/objectstores'
    local PRISM_ADMIN='admin'
    local PE_PASSWORD='techX2019!'

    # Payload for the _json_data
    _json_data='{"kind":"subnet"}'

    # Get the json data and split into CLUSTER_UUID and Primary_Network_UUID
    CLUSTER_UUID=$(curl -X POST -d $_json_data $CURL_HTTP_OPTS --user ${PRISM_ADMIN}:${PE_PASSWORD} $_url_network | jq '.entities[].spec | select (.name=="Primary") | .cluster_reference.uuid' | tr -d \")
    echo ${CLUSTER_UUID}

    PRIM_NETWORK_UUID=$(curl -X POST -d $_json_data $CURL_HTTP_OPTS --user ${PRISM_ADMIN}:${PE_PASSWORD} $_url_network | jq '.entities[] | select (.spec.name=="Primary") | .metadata.uuid' | tr -d \")
    echo ${PRIM_NETWORK_UUID}

    _json_data_oss='{"api_version":"3.0","metadata":{"kind":"objectstore"},"spec":{"name":"TEST","description":"NTNXLAB","resources":{"domain":"ntnxlab.local","cluster_reference":{"kind":"cluster","uuid":"'
    _json_data_oss+=${CLUSTER_UUID}
    _json_data_oss+='"},"buckets_infra_network_dns":"10.42.VLANX.16","buckets_infra_network_vip":"10.42.VLANX.17","buckets_infra_network_reference":{"kind":"subnet","uuid":"'
    _json_data_oss+=${PRIM_NETWORK_UUID}
    _json_data_oss+='"},"client_access_network_reference":{"kind":"subnet","uuid":"'
    _json_data_oss+=${PRIM_NETWORK_UUID}
    _json_data_oss+='"},"aggregate_resources":{"total_vcpu_count":10,"total_memory_size_mib":98304,"total_capacity_gib":51200},"client_access_network_ipv4_range":{"ipv4_start":"10.42.VLANX.18","ipv4_end":"10.42.VLANX.21"}}}}'

    # Set the right VLAN dynamically so we are configuring in the right network
    sed "s/VLANX/$VLAN/g"

    echo "curl -X POST -d $_json_data_oss $CURL_HTTP_OPTS --user ${PRISM_ADMIN}:${PE_PASSWORD} $_url_oss"

}

object_store

