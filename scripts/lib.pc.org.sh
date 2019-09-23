#!/usr/bin/env bash
# -x
# Dependencies: curl, ncli, nuclei, jq

function calm_update() {
  local  _attempts=12
  local  _calm_bin=/usr/local/nutanix/epsilon
  local _container
  local     _error=19
  local      _loop=0
  local     _sleep=10
  local       _url=http://${AUTH_HOST}:8080

  if [[ -e ${HOME}/epsilon.tar ]] && [[ -e ${HOME}/nucalm.tar ]]; then
    log "Bypassing download of updated containers."
  else
    dependencies 'install' 'sshpass' || exit 13
    remote_exec 'ssh' 'AUTH_SERVER' \
      'if [[ ! -e nucalm.tar ]]; then smbclient -I 10.21.249.12 \\\\pocfs\\images --user ${1} --command "prompt ; cd /Calm-EA/pc-'${PC_VERSION}'/ ; mget *tar"; echo; ls -lH *tar ; fi' \
      'OPTIONAL'

    while true ; do
      (( _loop++ ))
      _test=$(curl ${CURL_HTTP_OPTS} ${_url} \
        | tr -d \") # wonderful addition of "" around HTTP status code by cURL

      if (( ${_test} == 200 )); then
        log "Success reaching ${_url}"
        break;
      elif (( ${_loop} > ${_attempts} )); then
        log "Warning ${_error} @${1}: Giving up after ${_loop} tries."
        return ${_error}
      else
        log "@${1} ${_loop}/${_attempts}=${_test}: sleep ${_sleep} seconds..."
        sleep ${_sleep}
      fi
    done

    download ${_url}/epsilon.tar
    download ${_url}/nucacallm.tar
  fi

  if [[ -e ${HOME}/epsilon.tar ]] && [[ -e ${HOME}/nucalm.tar ]]; then
    ls -lh ${HOME}/*tar
    mkdir ${HOME}/calm.backup || true
    cp ${_calm_bin}/*tar ${HOME}/calm.backup/ \
    && genesis stop nucalm epsilon \
    && docker rm -f "$(docker ps -aq)" || true \
    && docker rmi -f "$(docker images -q)" || true \
    && cp ${HOME}/*tar ${_calm_bin}/ \
    && cluster start # ~75 seconds to start both containers

    for _container in epsilon nucalm ; do
      local _test=0
      while (( ${_test} < 1 )); do
        _test=$(docker ps -a | grep ${_container} | grep -i healthy | wc --lines)
      done
    done
  fi
}

function flow_enable() {
  ## (API; Didn't work. Used nuclei instead)
  ## https://localhost:9440/api/nutanix/v3/services/microseg
  ## {"state":"ENABLE"}
  # To disable flow run the following on PC: nuclei microseg.disable

  log "Enable Nutanix Flow..."
  nuclei microseg.enable 2>/dev/null
  nuclei microseg.get_status 2>/dev/null
}

function lcm() {
  local  _http_body
  local _pc_version
  local       _test

  # shellcheck disable=2206
  _pc_version=(${PC_VERSION//./ })

  if (( ${_pc_version[0]} >= 5 && ${_pc_version[1]} >= 9 )); then
    log "PC_VERSION ${PC_VERSION} >= 5.9, starting LCM inventory..."

    _http_body='{"value":"{\".oid\":\"LifeCycleManager\",\".method\":\"lcm_framework_rpc\",\".kwargs\":{\"method_class\":\"LcmFramework\",\"method\":\"perform_inventory\",\"args\":[\"http://download.nutanix.com/lcm/2.0\"]}}"}'

    _test=$(curl ${CURL_HTTP_OPTS} --user ${PRISM_ADMIN}:${PE_PASSWORD} -X POST --data "${_http_body}" \
      https://localhost:9440/PrismGateway/services/rest/v1/genesis)
    log "inventory _test=|${_test}|"
  fi
}

function pc_admin() {
  local  _http_body
  local       _test
  local _admin_user='marklavi'

  _http_body=$(cat <<EOF
  {"profile":{
    "username":"${_admin_user}",
    "firstName":"Mark",
    "lastName":"Lavi",
    "emailId":"${EMAIL}",
    "password":"${PE_PASSWORD}",
    "locale":"en-US"},"enabled":false,"roles":[]}
EOF
  )
  _test=$(curl ${CURL_HTTP_OPTS} \
    --user ${PRISM_ADMIN}:${PE_PASSWORD} -X POST --data "${_http_body}" \
    https://localhost:9440/PrismGateway/services/rest/v1/users)
  log "create.user=${_admin_user}=|${_test}|"

  _http_body='["ROLE_USER_ADMIN","ROLE_MULTICLUSTER_ADMIN"]'
       _test=$(curl ${CURL_HTTP_OPTS} \
    --user ${PRISM_ADMIN}:${PE_PASSWORD} -X POST --data "${_http_body}" \
    https://localhost:9440/PrismGateway/services/rest/v1/users/${_admin_user}/roles)
  log "add.roles ${_http_body}=|${_test}|"
}

function pc_auth() {
  # TODO:190 configure case for each authentication server type?
  local      _group
  local  _http_body
  local _pc_version
  local       _test

  # TODO:50 FUTURE: pass AUTH_SERVER argument

  log "Add Directory ${AUTH_SERVER}"
  _http_body=$(cat <<EOF
{"name":"${AUTH_SERVER}","domain":"${AUTH_FQDN}","directoryType":"ACTIVE_DIRECTORY","connectionType":"LDAP",
EOF
  )

  # shellcheck disable=2206
  _pc_version=(${PC_VERSION//./ })

  log "Checking if PC_VERSION ${PC_VERSION} >= 5.9"
  if (( ${_pc_version[0]} >= 5 && ${_pc_version[1]} >= 9 )); then
    _http_body+=$(cat <<EOF
"groupSearchType":"RECURSIVE","directoryUrl":"ldap://${AUTH_HOST}:${LDAP_PORT}",
EOF
)
  else
    _http_body+=" \"directoryUrl\":\"ldaps://${AUTH_HOST}/\","
  fi

  _http_body+=$(cat <<EOF
    "serviceAccountUsername":"${AUTH_ADMIN_USER}",
    "serviceAccountPassword":"${AUTH_ADMIN_PASS}"
  }
EOF
  )

  _test=$(curl ${CURL_POST_OPTS} --user ${PRISM_ADMIN}:${PE_PASSWORD} -X POST --data "${_http_body}" \
    https://localhost:9440/PrismGateway/services/rest/v1/authconfig/directories)
  log "directories: _test=|${_test}|_http_body=|${_http_body}|"

  log "Add Role Mappings to Groups for PC logins (not projects, which are separate)..."
  #TODO:20 hardcoded role mappings
  for _group in 'SSP Admins' 'SSP Power Users' 'SSP Developers' 'SSP Basic Users'; do
    _http_body=$(cat <<EOF
    {
      "directoryName":"${AUTH_SERVER}",
      "role":"ROLE_CLUSTER_ADMIN",
      "entityType":"GROUP",
      "entityValues":["${_group}"]
    }
EOF
    )
    _test=$(curl ${CURL_POST_OPTS} \
      --user ${PRISM_ADMIN}:${PE_PASSWORD} -X POST --data "${_http_body}" \
      https://localhost:9440/PrismGateway/services/rest/v1/authconfig/directories/${AUTH_SERVER}/role_mappings)
    log "Cluster Admin=${_group}, _test=|${_test}|"
  done
}

function pc_cluster_img_import() {
  local _http_body
  local      _test
  local      _uuid

       _uuid=$(source /etc/profile.d/nutanix_env.sh \
              && ncli --json=true cluster info \
              | jq -r .data.uuid)
  _http_body=$(cat <<EOF
{"action_on_failure":"CONTINUE",
 "execution_order":"SEQUENTIAL",
 "api_request_list":[{
   "operation":"POST",
   "path_and_params":"/api/nutanix/v3/images/migrate",
   "body":{
     "image_reference_list":[],
     "cluster_reference":{
       "uuid":"${_uuid}",
       "kind":"cluster",
       "name":"string"}}}],
 "api_version":"3.0"}
EOF
  )
  _test=$(curl ${CURL_HTTP_OPTS} --user ${PRISM_ADMIN}:${PE_PASSWORD} -X POST --data "${_http_body}" \
    https://localhost:9440/api/nutanix/v3/batch)
  log "batch _test=|${_test}|"
}

function pc_dns_add() {
  local _dns_server
  local       _test

  for _dns_server in $(echo "${DNS_SERVERS}" | sed -e 's/,/ /'); do
    _test=$(curl ${CURL_HTTP_OPTS} --user ${PRISM_ADMIN}:${PE_PASSWORD} -X POST --data "[\"$_dns_server\"]" \
      https://localhost:9440/PrismGateway/services/rest/v1/cluster/name_servers/add_list)
    log "name_servers/add_list |${_dns_server}| _test=|${_test}|"
  done
}

function pc_init() {
  # TODO:130 pc_init: NCLI, type 'cluster get-smtp-server' config for idempotency?
  local _test

  log "Configure NTP@PC"
  ncli cluster add-to-ntp-servers \
    servers=0.us.pool.ntp.org,1.us.pool.ntp.org,2.us.pool.ntp.org,3.us.pool.ntp.org

  log "Validate EULA@PC"
  _test=$(curl ${CURL_HTTP_OPTS} --user ${PRISM_ADMIN}:${PE_PASSWORD} -X POST -d '{
      "username": "SE",
      "companyName": "NTNX",
      "jobTitle": "SE"
  }' https://localhost:9440/PrismGateway/services/rest/v1/eulas/accept)
  log "EULA _test=|${_test}|"

  log "Disable Pulse@PC"
  _test=$(curl ${CURL_HTTP_OPTS} --user ${PRISM_ADMIN}:${PE_PASSWORD} -X PUT -d '{
      "emailContactList":null,
      "enable":false,
      "verbosityType":null,
      "enableDefaultNutanixEmail":false,
      "defaultNutanixEmail":null,
      "nosVersion":null,
      "isPulsePromptNeeded":false,
      "remindLater":null
  }' https://localhost:9440/PrismGateway/services/rest/v1/pulse)
  log "PULSE _test=|${_test}|"
}

function pc_smtp() {
  log "Configure SMTP@PC"
  local _sleep=5

  args_required 'SMTP_SERVER_ADDRESS SMTP_SERVER_FROM SMTP_SERVER_PORT'
  ncli cluster set-smtp-server port=${SMTP_SERVER_PORT} \
    address=${SMTP_SERVER_ADDRESS} from-email-address=${SMTP_SERVER_FROM}
  #log "sleep ${_sleep}..."; sleep ${_sleep}
  #log $(ncli cluster get-smtp-server | grep Status | grep success)

  # shellcheck disable=2153
  ncli cluster send-test-email recipient="${EMAIL}" \
    subject="pc_smtp https://${PRISM_ADMIN}:${PE_PASSWORD}@${PC_HOST}:9440 Testing."
  # local _test=$(curl ${CURL_HTTP_OPTS} --user ${PRISM_ADMIN}:${PE_PASSWORD} -X POST -d '{
  #   "address":"${SMTP_SERVER_ADDRESS}","port":"${SMTP_SERVER_PORT}","username":null,"password":null,"secureMode":"NONE","fromEmailAddress":"${SMTP_SERVER_FROM}","emailStatus":null}' \
  #   https://localhost:9440/PrismGateway/services/rest/v1/cluster/smtp)
  # log "_test=|${_test}|"
}

function pc_passwd() {
  args_required 'PRISM_ADMIN PE_PASSWORD'

  log "Reset PC password to PE password, must be done by ncli@PC, not API or on PE"
  ncli user reset-password user-name=${PRISM_ADMIN} password=${PE_PASSWORD}
  if (( $? > 0 )); then
   log "Warning: password not reset: $?."# exit 10
  fi
  # TOFIX: nutanix@PC Linux account password change as well?

  # local _old_pw='nutanix/4u'
  # local _http_body=$(cat <<EOF
  # {"oldPassword": "${_old_pw}","newPassword": "${PE_PASSWORD}"}
  # EOF
  # )
  # local _test
  # _test=$(curl ${CURL_HTTP_OPTS} --user "${PRISM_ADMIN}:${_old_pw}" -X POST --data "${_http_body}" \
  #     https://localhost:9440/PrismGateway/services/rest/v1/utils/change_default_system_password)
  # log "cURL reset password _test=${_test}"
}

function ssp_auth() {
  args_required 'AUTH_SERVER AUTH_HOST AUTH_ADMIN_USER AUTH_ADMIN_PASS'

  local   _http_body
  local   _ldap_name
  local   _ldap_uuid
  local _ssp_connect

  log "Find ${AUTH_SERVER} uuid"
  _ldap_uuid=$(PATH=${PATH}:${HOME}; curl ${CURL_POST_OPTS} \
    --user ${PRISM_ADMIN}:${PE_PASSWORD} --data '{ "kind": "directory_service" }' \
    https://localhost:9440/api/nutanix/v3/directory_services/list \
    | jq -r .entities[0].metadata.uuid)
  log "_ldap_uuid=|${_ldap_uuid}|"

  # TODO:110 get directory service name _ldap_name
  _ldap_name=${AUTH_SERVER}
  # TODO:140 bats? test ldap connection

  log "Connect SSP Authentication (spec-ssp-authrole.json)..."
  _http_body=$(cat <<EOF
  {
    "spec": {
      "name": "${AUTH_SERVER}",
      "resources": {
        "admin_group_reference_list": [
          {
            "name": "cn=ssp developers,cn=users,dc=ntnxlab,dc=local",
            "uuid": "3933a846-fe73-4387-bb39-7d66f222c844",
            "kind": "user_group"
          }
        ],
        "service_account": {
          "username": "${AUTH_ADMIN_USER}",
          "password": "${AUTH_ADMIN_PASS}"
        },
        "url": "ldaps://${AUTH_HOST}/",
        "directory_type": "ACTIVE_DIRECTORY",
        "admin_user_reference_list": [],
        "domain_name": "${AUTH_DOMAIN}"
      }
    },
    "metadata": {
      "kind": "directory_service",
      "spec_version": 0,
      "uuid": "${_ldap_uuid}",
      "categories": {}
    },
    "api_version": "3.1.0"
  }
EOF
  )
  _ssp_connect=$(curl ${CURL_POST_OPTS} \
    --user ${PRISM_ADMIN}:${PE_PASSWORD} -X PUT --data "${_http_body}" \
    https://localhost:9440/api/nutanix/v3/directory_services/${_ldap_uuid})
  log "_ssp_connect=|${_ssp_connect}|"

  # TODO:120 SSP Admin assignment, cluster, networks (default project?) = spec-project-config.json
  # PUT https://localhost:9440/api/nutanix/v3/directory_services/9d8c2c33-9d95-438c-a7f4-2187120ae99e = spec-ssp-direcory_service.json
  # TODO:60 FUTURE: use directory_type variable?
  log "Enable SSP Admin Authentication (spec-ssp-direcory_service.json)..."
  _http_body=$(cat <<EOF
  {
    "spec": {
      "name": "${_ldap_name}",
      "resources": {
        "service_account": {
          "username": "${AUTH_ADMIN_USER}@${AUTH_FQDN}",
          "password": "${AUTH_ADMIN_PASS}"
        },
        "url": "ldaps://${AUTH_HOST}/",
        "directory_type": "ACTIVE_DIRECTORY",
        "domain_name": "${AUTH_DOMAIN}"
      }
    },
    "metadata": {
      "kind": "directory_service",
      "spec_version": 0,
      "uuid": "${_ldap_uuid}",
      "categories": {}
    },
    "api_version": "3.1.0"
  }
EOF
  )
  _ssp_connect=$(curl ${CURL_POST_OPTS} \
    --user ${PRISM_ADMIN}:${PE_PASSWORD} -X PUT --data "${_http_body}" \
    https://localhost:9440/api/nutanix/v3/directory_services/${_ldap_uuid})
  log "_ssp_connect=|${_ssp_connect}|"
  # POST https://localhost:9440/api/nutanix/v3/groups = spec-ssp-groups.json
  # TODO:100 can we skip previous step?
  log "Enable SSP Admin Authentication (spec-ssp-groupauth_2.json)..."
  _http_body=$(cat <<EOF
  {
    "spec": {
      "name": "${_ldap_name}",
      "resources": {
        "service_account": {
          "username": "${AUTH_ADMIN_USER}@${AUTH_DOMAIN}",
          "password": "${AUTH_ADMIN_PASS}"
        },
        "url": "ldaps://${AUTH_HOST}/",
        "directory_type": "ACTIVE_DIRECTORY",
        "domain_name": "${AUTH_DOMAIN}"
        "admin_user_reference_list": [],
        "admin_group_reference_list": [
          {
            "kind": "user_group",
            "name": "cn=ssp admins,cn=users,dc=ntnxlab,dc=local",
            "uuid": "45d495e1-b797-4a26-a45b-0ef589b42186"
          }
        ]
      }
    },
    "api_version": "3.1",
    "metadata": {
      "last_update_time": "2018-09-14T13:02:55Z",
      "kind": "directory_service",
      "uuid": "${_ldap_uuid}",
      "creation_time": "2018-09-14T13:02:55Z",
      "spec_version": 2,
      "owner_reference": {
        "kind": "user",
        "name": "admin",
        "uuid": "00000000-0000-0000-0000-000000000000"
      },
      "categories": {}
    }
  }
EOF
    )
    _ssp_connect=$(curl ${CURL_POST_OPTS} \
      --user ${PRISM_ADMIN}:${PE_PASSWORD} -X PUT --data "${_http_body}" \
      https://localhost:9440/api/nutanix/v3/directory_services/${_ldap_uuid})
    log "_ssp_connect=|${_ssp_connect}|"

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
  _test=$(curl ${CURL_POST_OPTS} \
    --user ${PRISM_ADMIN}:${PE_PASSWORD} -X POST --data "${_http_body}" \
    https://localhost:9440/api/nutanix/v3/services/nucalm)
  log "_test=|${_test}|"
}

function pc_ui() {
  # http://vcdx56.com/2017/08/change-nutanix-prism-ui-login-screen/
  local  _http_body
  local       _json
  local _pc_version
  local       _test
#{"type":"WELCOME_BANNER","username":"system_data","key":"welcome_banner_content","value":"${PRISM_ADMIN}:${PE_PASSWORD}@${CLUSTER_NAME}"} \
  _json=$(cat <<EOF
{"type":"custom_login_screen","key":"color_in","value":"#ADD100"} \
{"type":"custom_login_screen","key":"color_out","value":"#11A3D7"} \
{"type":"custom_login_screen","key":"product_title","value":"${CLUSTER_NAME},PC-${PC_VERSION}"} \
{"type":"custom_login_screen","key":"title","value":"Nutanix.HandsOnWorkshops.com,@${AUTH_FQDN}"} \
{"type":"WELCOME_BANNER","username":"system_data","key":"welcome_banner_status","value":true} \
{"type":"WELCOME_BANNER","username":"system_data","key":"welcome_banner_content","value":"${PRISM_ADMIN}:${PE_PASSWORD}"} \
{"type":"WELCOME_BANNER","username":"system_data","key":"disable_video","value":true} \
{"type":"UI_CONFIG","username":"system_data","key":"disable_2048","value":true} \
{"type":"UI_CONFIG","key":"autoLogoutGlobal","value":7200000} \
{"type":"UI_CONFIG","key":"autoLogoutOverride","value":0} \
{"type":"UI_CONFIG","key":"welcome_banner","value":"https://Nutanix.HandsOnWorkshops.com/workshops/6070f10d-3aa0-4c7e-b727-dc554cbc2ddf/start/"}
EOF
  )

  for _http_body in ${_json}; do
    _test=$(curl ${CURL_HTTP_OPTS} \
      --user ${PRISM_ADMIN}:${PE_PASSWORD} -X POST --data "${_http_body}" \
      https://localhost:9440/PrismGateway/services/rest/v1/application/system_data)
    log "_test=|${_test}|${_http_body}"
  done

  _http_body='{"type":"UI_CONFIG","key":"autoLogoutTime","value": 3600000}'
       _test=$(curl ${CURL_HTTP_OPTS} \
    --user ${PRISM_ADMIN}:${PE_PASSWORD} -X POST --data "${_http_body}" \
    https://localhost:9440/PrismGateway/services/rest/v1/application/user_data)
  log "autoLogoutTime _test=|${_test}|"

  # shellcheck disable=2206
  _pc_version=(${PC_VERSION//./ })

  if (( ${_pc_version[0]} >= 5 && ${_pc_version[1]} >= 10 && ${_test} != 500 )); then
    log "PC_VERSION ${PC_VERSION} >= 5.10, setting favorites..."

    _json=$(cat <<EOF
{"complete_query":"Karbon","route":"ebrowser/k8_cluster_entitys"} \
{"complete_query":"Images","route":"ebrowser/image_infos"} \
{"complete_query":"Projects","route":"ebrowser/projects"} \
{"complete_query":"Calm","route":"calm"}
EOF
    )

    for _http_body in ${_json}; do
      _test=$(curl ${CURL_HTTP_OPTS} --user ${PRISM_ADMIN}:${PE_PASSWORD} -X POST --data "${_http_body}" \
        https://localhost:9440/api/nutanix/v3/search/favorites)
      log "favs _test=|${_test}|${_http_body}"
    done
  fi
}

function pc_project() {
  local  _name
  local _count
  local  _uuid

   _name=${EMAIL%%@nutanix.com}.test
  _count=$(. /etc/profile.d/nutanix_env.sh \
    && nuclei project.list 2>/dev/null | grep ${_name} | wc --lines)
  if (( ${_count} > 0 )); then
    nuclei project.delete ${_name} confirm=false 2>/dev/null
  else
    log "Warning: _count=${_count}"
  fi

  log "Creating ${_name}..."
  nuclei project.create name=${_name} description='test from NuCLeI!' 2>/dev/null
  _uuid=$(. /etc/profile.d/nutanix_env.sh \
    && nuclei project.get ${_name} format=json 2>/dev/null \
    | jq .metadata.project_reference.uuid | tr -d '"')
  log "${_name}.uuid = ${_uuid}"

    # - project.get mark.lavi.test
    # - project.update mark.lavi.test
    #     spec.resources.account_reference_list.kind= or .uuid
    #     spec.resources.default_subnet_reference.kind=
    #     spec.resources.environment_reference_list.kind=
    #     spec.resources.external_user_group_reference_list.kind=
    #     spec.resources.subnet_reference_list.kind=
    #     spec.resources.user_reference_list.kind=

    # {"spec":{"access_control_policy_list":[],"project_detail":{"name":"mark.lavi.test1","resources":{"external_user_group_reference_list":[],"user_reference_list":[],"environment_reference_list":[],"account_reference_list":[],"subnet_reference_list":[{"kind":"subnet","name":"Primary","uuid":"a4000fcd-df41-42d7-9ffe-f1ab964b2796"},{"kind":"subnet","name":"Secondary","uuid":"4689bc7f-61dd-4527-bc7a-9d737ae61322"}],"default_subnet_reference":{"kind":"subnet","uuid":"a4000fcd-df41-42d7-9ffe-f1ab964b2796"}},"description":"test from NuCLeI!"},"user_list":[],"user_group_list":[]},"api_version":"3.1","metadata":{"creation_time":"2018-06-22T03:54:59Z","spec_version":0,"kind":"project","last_update_time":"2018-06-22T03:55:00Z","uuid":"1be7f66a-5006-4061-b9d2-76caefedd298","categories":{},"owner_reference":{"kind":"user","name":"admin","uuid":"00000000-0000-0000-0000-000000000000"}}}
}
