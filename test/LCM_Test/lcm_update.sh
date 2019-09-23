#################################################################
# Grab the json from the possible to be updated UUIDs and versions and save local in reply_json.json
#################################################################
_url_groups='https://10.42.8.39:9440/api/nutanix/v3/groups'
CURL_HTTP_OPTS=' --silent --max-time 25 --header Content-Type:application/json --header Accept:application/json  --insecure '
PRISM_ADMIN="admin"
PE_PASSWORD="techX2019!"

# Run the Curl command and save the oputput in a temp file
curl $CURL_HTTP_OPTS --user $PRISM_ADMIN:$PE_PASSWORD -X POST -d '{"entity_type": "lcm_available_version","grouping_attribute": "entity_uuid","group_member_count": 1000,"group_member_attributes": [{"attribute": "uuid"},{"attribute": "entity_uuid"},{"attribute": "entity_class"},{"attribute": "status"},{"attribute": "version"},{"attribute": "dependencies"},{"attribute": "order"}]}'  $_url_groups > reply_json.json

# Fill the uuid array with the correct values
my_arr=($(jq '.group_results[].entity_results[].data[] | select (.name=="entity_uuid") | .values[0].values[0]' reply_json.json | sort -u | tr "\"" " " | tr -s " "))

# Grabbing the versions of the UUID and put them in a versions array
for uuid in "${my_arr[@]}"
do
  version_ar+=($(jq --arg uuid "$uuid" '.group_results[].entity_results[] | select (.data[].values[].values[0]==$uuid) | select (.data[].name=="version") | .data[].values[].values[0]' reply-inventory.json | tail -4 | head -n 1))
done

# Combine the two values to the full needed data
count=0
while [ $count -lt ${#my_arr[@]} ]
do
   echo "$count: UUID is ${my_arr[$count]} and the version is ${version_ar[$count]}"
   let count=count+1
done