

HTTP_CACHE_HOST='localhost'
HTTP_CACHE_PORT=8181

    AUTH_SERVER='AutoDC' # default; TODO:180 refactor AUTH_SERVER choice to input file
      AUTH_HOST="${IPV4_PREFIX}.$((${OCTET[3]} + 3))"
      LDAP_PORT=389
      AUTH_FQDN='ntnxlab.local'
    AUTH_DOMAIN='NTNXLAB'
AUTH_ADMIN_USER='administrator@'${AUTH_FQDN}
AUTH_ADMIN_PASS='nutanix/4u'
AUTH_ADMIN_GROUP='SSP Admins'
   AUTODC_REPOS=(\
  'http://10.42.8.50/images/AutoDC.qcow2' \
  'http://10.42.8.50/images/AutoDC2.qcow2' \
  'https://s3.amazonaws.com/get-ahv-images/AutoDC.qcow2' \
  'https://s3.amazonaws.com/get-ahv-images/AutoDC2.qcow2' \

  #'nfs://pocfs.nutanixdc.local/images/CorpSE_Calm/autodc-2.0.qcow2' \
 # 'smb://pocfs.nutanixdc.local/images/CorpSE_Calm/autodc-2.0.qcow2' \
  #'http://10.59.103.143:8000/autodc-2.0.qcow2' \

)

# For Nutanix HPOC/Marketing clusters (10.20, 10.21, 10.55, 10.42)
# https://sewiki.nutanix.com/index.php/HPOC_IP_Schema
case "${OCTET[0]}.${OCTET[1]}" in
  10.20 ) #Marketing: us-west = SV
    DNS_SERVERS='10.21.253.10'
    ;;
  10.21 ) #HPOC: us-west = SV
    if (( ${OCTET[2]} == 60 )) || (( ${OCTET[2]} == 77 )); then
      log 'GPU cluster, aborting! See https://sewiki.nutanix.com/index.php/Hosted_Proof_of_Concept_(HPOC)#GPU_Clusters'
      exit 0
    fi

    # backup cluster; override relative IP addressing
    if (( ${OCTET[2]} == 249 )); then
      AUTH_HOST="${IPV4_PREFIX}.118"
        PC_HOST="${IPV4_PREFIX}.119"
    fi

       DNS_SERVERS='10.21.253.10,10.21.253.11'
          NW2_NAME='Secondary'
          NW2_VLAN=$(( ${OCTET[2]} * 10 + 1 ))
        NW2_SUBNET="${IPV4_PREFIX}.129/25"
    NW2_DHCP_START="${IPV4_PREFIX}.132"
      NW2_DHCP_END="${IPV4_PREFIX}.253"
    ;;
  10.55 ) # HPOC us-east = DUR
       DNS_SERVERS='10.21.253.11'
          NW2_NAME='Secondary'
          NW2_VLAN=$(( ${OCTET[2]} * 10 + 1 ))
        NW2_SUBNET="${IPV4_PREFIX}.129/25"
    NW2_DHCP_START="${IPV4_PREFIX}.132"
      NW2_DHCP_END="${IPV4_PREFIX}.253"
    ;;
  10.42 ) # HPOC us-west = PHX
       DNS_SERVERS='10.42.196.10'
          NW2_NAME='Secondary'
          NW2_VLAN=$(( ${OCTET[2]} * 10 + 1 ))
        NW2_SUBNET="${IPV4_PREFIX}.129/25"
    NW2_DHCP_START="${IPV4_PREFIX}.132"
      NW2_DHCP_END="${IPV4_PREFIX}.253"
    ;;
  10.132 ) # https://sewiki.nutanix.com/index.php/SH-COLO-IP-ADDR
       DNS_SERVERS='10.132.71.40'
        NW1_SUBNET="${IPV4_PREFIX%.*}.128.4/17"
    NW1_DHCP_START="${IPV4_PREFIX}.100"
      NW1_DHCP_END="${IPV4_PREFIX}.250"
      # PC deploy file local override, TODO:30 make an PC_URL array and eliminate
               PC_CURRENT_URL=http://10.132.128.50/E%3A/share/Nutanix/PrismCentral/pc-${PC_VERSION}-deploy.tar
       PC_CURRENT_METAURL=http://10.132.128.50/E%3A/share/Nutanix/PrismCentral/pc-${PC_VERSION}-deploy-metadata.json
    PC_STABLE_METAURL=${PC_CURRENT_METAURL}

    QCOW2_IMAGES=(\
      Centos7-Base.qcow2 \
      Centos7-Update.qcow2 \
      Windows2012R2.qcow2 \
      panlm-img-52.qcow2 \
      kx_k8s_01.qcow2 \
      kx_k8s_02.qcow2 \
      kx_k8s_03.qcow2 \
    )
    ;;
esac

HTTP_CACHE_HOST='localhost'
HTTP_CACHE_PORT=8181

   ATTEMPTS=40
      SLEEP=60 # pause (in seconds) between ATTEMPTS

     CURL_OPTS='--insecure --silent --show-error' # --verbose'
CURL_POST_OPTS="${CURL_OPTS} --max-time 5 --header Content-Type:application/json --header Accept:application/json --output /dev/null"
CURL_HTTP_OPTS="${CURL_POST_OPTS} --write-out %{http_code}"
      SSH_OPTS='-o StrictHostKeyChecking=no -o GlobalKnownHostsFile=/dev/null -o UserKnownHostsFile=/dev/null'
     SSH_OPTS+=' -q' # -v'
