#!/bin/bash
CURL_HTTP_OPTS=' --max-time 25 --silent --header Content-Type:application/json --header Accept:application/json  --insecure --write-out %{http_code}' # --output /dev/null --silent --show-error
PRISM_ADMIN='admin'
PE_PASSWORD='techX2019!'
_url_lcm='https://localhost:9440/PrismGateway/services/rest/v1/genesis'
_url_progress='https://localhost:9440/PrismGateway/services/rest/v1/progress_monitors'
_url_groups='https://localhost:9440/api/nutanix/v3/groups'

###############################################################################################################################################################################
# Routine to be run/loop till yes we are ok.
###############################################################################################################################################################################
function loop(){

  local _attempts=40
  local _error=22
  local _loops=0
  local _sleep=30

  if [ -z "$1" ]; then
    echo "No parameter"
  else
    _task_id=$1
  fi

  # What is the progress of the taskid?? 
  while true; do
    (( _loops++ ))
    # Get the progress of the task  
    _progress=$(curl ${CURL_HTTP_OPTS} --user ${PRISM_ADMIN}:${PE_PASSWORD} ${_url_progress}?filterCriteria=parent_task_uuid%3D%3D${_task_id} | jq '.entities[0].percentageCompleted' 2>nul | tr -d \")
    if (( ${_progress} == 100 )); then
      echo "The step has been succesfuly run"
      set _error=0
      break;
    elif (( ${_loops} > ${_attempts} )); then
      echo "Warning ${_error} @${1}: Giving up after ${_loop} tries."
      return ${_error}
    else
      echo "Still running... loop $_loops/$_attempts. Step is at ${_progress}% ...Sleeping ${_sleep} seconds"
      sleep ${_sleep}
    fi
  done
}

function calm_enable() {
  local _http_body
  local _test

  log "Enable Nutanix Calm..."
  _http_body=$(cat <<EOF
  {
    "state": "ENABLE",
    "enable_nutanix_apps": true
  }
EOF
  )
  _http_body='{"enable_nutanix_apps":true,"state":"ENABLE"}'
  _test=$(curl ${CURL_HTTP_OPTS} \
    --user ${PRISM_ADMIN}:${PE_PASSWORD} -X POST --data "${_http_body}" \
    https://localhost:9440/api/nutanix/v3/services/nucalm)
  log "_test=|${_test}|"

  # Create the task_id so we can loop on that to make sure it is running
  _task_id=$(echo ${_test::-4} | cut -d "\"" -f 4)
  loop
}

# Call the Cal_enable routine to start Calm

calm_enable

# Inventory download/run
_task_id=$(curl ${CURL_HTTP_OPTS} --user ${PRISM_ADMIN}:${PE_PASSWORD} -X POST -d '{"value":"{\".oid\":\"LifeCycleManager\",\".method\":\"lcm_framework_rpc\",\".kwargs\":{\"method_class\":\"LcmFramework\",\"method\":\"perform_inventory\",\"args\":[\"http://download.nutanix.com/lcm/2.0\"]}}"}' ${_url_lcm} | jq '.value' 2>nul | cut -d "\\" -f 4 | tr -d \")

# If there has been a reply (task_id) then the URL has accepted by PC
if [ -z "$_task_id" ]; then
  echo "LCM Inventory start has encountered an eror..."
else
  echo "LCM Inventory started.."
  set _loops=0 # Reset the loop counter

 # Run the progess checker
 loop

 # We need to get the UUIDs and the versions to be used.. so we can start the update. They are in the /home/nutanix/data/logs/lcm_ops.out AFTER an inventory run!
 _full_uuids=$(cat /home/nutanix/data/logs/lcm_ops.out | grep -A 1 entity_uuid | grep -B 1 "2.6.0.3")
 # As we need to have the latest version from the LCM we need to reverse the string so we get the last (rev) version
 _first_uuid=$(echo $_full_uuids |rev|cut -d":" -f 4 |rev | cut -d "\"" -f2)
 _first_version="2.6.0.3"
 _sec_uuid=$(echo $_full_uuids rev|rev | cut -d":" -f 2 |rev | cut -d "\"" -f2)
 _sec_version=$_first_version

 #echo "This values have been found:" $_first_uuid" and " $_first_version " and " $_sec_uuid " and " $_sec_version

 # Set the parameter to create the ugrade plan
 # Create the curl json string -d xyz
 _json_data="-d "
 _json_data+="{\"value\":\"{\\\".oid\\\":\\\"LifeCycleManager\\\",\\\".method\\\":\\\"lcm_framework_rpc\\\",\\\".kwargs\\\":{\\\"method_class\\\":\\\"LcmFramework\\\",\\\"method\\\":\\\"generate_plan\\\",\\\"args\\\":[\\\"http://download.nutanix.com/lcm/2.0\\\",[[\\\""
 _json_data+=$_first_uuid
 _json_data+="\\\",\\\""
 _json_data+=$_first_version
 _json_data+="\\\"],[\\\""
 _json_data+=$_sec_uuid
 _json_data+="\\\",\\\""
 _json_data+=$_sec_version
 _json_data+="\\\"]]]}}\"}"


 # Run the generate plan task
 _task_id=$(curl ${CURL_HTTP_OPTS} --user ${PRISM_ADMIN}:${PE_PASSWORD} -X POST $_json_data ${_url_lcm})

 # Notify the log server that the LCM has been creating a plan
 echo "LCM Inventory has created a plan"
 set _loops=0 # Reset the loop counter
 
 # Create new json data string
 _json_data="-d "
 _json_data+="{\"value\":\"{\\\".oid\\\":\\\"LifeCycleManager\\\",\\\".method\\\":\\\"lcm_framework_rpc\\\",\\\".kwargs\\\":{\\\"method_class\\\":\\\"LcmFramework\\\",\\\"method\\\":\\\"perform_update\\\",\\\"args\\\":[\\\"http://download.nutanix.com/lcm/2.0\\\",[[\\\""
 _json_data+=$_first_uuid
 _json_data+="\\\",\\\""
 _json_data+=$_first_version
 _json_data+="\\\"],[\\\""
 _json_data+=$_sec_uuid
 _json_data+="\\\",\\\""
 _json_data+=$_sec_version
 _json_data+="\\\"]]]}}\"}"


 # Run the upgrade to have the latest versions
 _task_id=$(curl ${CURL_HTTP_OPTS} --user ${PRISM_ADMIN}:${PE_PASSWORD} -X POST $_json_data ${_url_lcm} | jq '.value' 2>nul | cut -d "\\" -f 4 | tr -d \")

 # If there has been a reply task_id then the URL has accepted by PC
 if [ -z "$_task_id" ]; then
   # There has been an error!!!
   echo "LCM Upgrade has encountered an error!!!!"
 else
   # Notify the logserver that we are starting the LCM Upgrade
   echo "LCM Upgrade starting..."

  # Run the progess checker
  loop
 fi
fi