#!/usr/bin/env bash

# Example use from a Nutanix CVM:
# curl --remote-name --location https://raw.githubusercontent.com/nutanixworkshops/stageworkshop/master/bootstrap.sh && sh ${_##*/}
#
# Development/Beta version
# curl --remote-name --location https://raw.githubusercontent.com/jncox/stageworkshop/master/bootstrap.sh && sh ${_##*/}
#
# For testing:
# curl --remote-name --location https://raw.githubusercontent.com/mlavi/stageworkshop/master/bootstrap.sh && SOURCE=${_} sh ${_##*/}

if [[ -z ${SOURCE} ]]; then
  ORGANIZATION=jncox
    REPOSITORY=stageworkshop
        BRANCH=master
else
  # shellcheck disable=2206
    URL_SOURCE=(${SOURCE//\// }) # zero index
  ORGANIZATION=${URL_SOURCE[2]}
    REPOSITORY=${URL_SOURCE[3]}
        BRANCH=${URL_SOURCE[4]}
fi

BASE_URL=https://github.com/${ORGANIZATION}/${REPOSITORY}
 ARCHIVE=${BASE_URL}/archive/${BRANCH}.zip

case "${1}" in
  clean )
    echo "Cleaning up..."
    rm -rf ${ARCHIVE##*/} ${0} ${REPOSITORY}-${BRANCH}/
    exit 0
    ;;
  cache )
    cache
    ;;
  *)
    WORKSHOP="${1}"
    ;;
esac

if [[ -f ${BRANCH}.zip ]]; then
  sh ${HOME}/${0} clean
fi

echo -e "\nFor details, please see: ${BASE_URL}/documentation/guidebook.md"

_ERROR=0

. /etc/profile.d/nutanix_env.sh || _ERROR=1

if (( ${_ERROR} == 1 )); then
  echo "Error ${_ERROR}: This script should be run on a Nutanix CVM!"
  #echo RESTORE:

#########################################################################
### Added to verify user is Nutanix 7/22/2019 from mlavi version of file.
#########################################################################

  exit ${_ERROR}
elif [[ $(whoami) != 'nutanix' ]]; then
  _ERROR=50
  echo "PBC-50: This guardrail can be relaxed with proper testing for the future."
  echo "Error ${_ERROR}: This script should be run as user nutanix!"
  exit ${_ERROR}
fi

CLUSTER_NAME=' '
CLUSTER_NAME+=$(ncli cluster get-params | grep 'Cluster Name' \
              | awk -F: '{print $2}' | tr -d '[:space:]')
EMAIL_DOMAIN=nutanix.com

if [[ -z ${PE_PASSWORD} ]]; then
  _PRISM_ADMIN='admin'
  echo -e "\n    Note: Hit [Return] to use the default answer inside brackets.\n"
  read -p "Optional: What is this cluster's admin username? [${_PRISM_ADMIN}] " PRISM_ADMIN
  if [[ -z ${PRISM_ADMIN} ]]; then
    PRISM_ADMIN=${_PRISM_ADMIN}
  fi

  echo -e "\n    Note: Password will not be displayed."
  read -s -p "REQUIRED: What is this${CLUSTER_NAME} cluster's admin password? " -r _PW1 ; echo
  read -s -p " CONFIRM:             ${CLUSTER_NAME} cluster's admin password? " -r _PW2 ; echo

  if [[ ${_PW1} != "${_PW2}" ]]; then
    _ERROR=1
    echo "Error ${_ERROR}: passwords do not match."
    exit ${_ERROR}
  else
    PE_PASSWORD=${_PW1}
    unset _PW1 _PW2
  fi
fi

if [[ -z ${EMAIL} ]]; then
  echo -e "\n    Note: @${EMAIL_DOMAIN} will be added if domain omitted."
  read -p "REQUIRED: Email address for cluster admin? " EMAIL
fi

_WC_ARG='--lines'
if [[ $(uname -s) == 'Darwin' ]]; then
  _WC_ARG='-l'
fi
if (( $(echo ${EMAIL} | grep @ | wc ${_WC_ARG}) == 0 )); then
  EMAIL+=@${EMAIL_DOMAIN}
fi

if [[ -d ../${REPOSITORY}-${BRANCH} ]]; then
  echo "Reusing downloaded archive, consider using $0 clean instead."
  pushd ..
elif [[ ! -d ${REPOSITORY}-${BRANCH} ]]; then
  echo -e "\nNo cache: retrieving ${ARCHIVE} ..."
  curl --remote-name --location ${ARCHIVE} \
  && echo "Success: ${ARCHIVE##*/}" \
  && unzip ${ARCHIVE##*/}
fi

pushd ${REPOSITORY}-${BRANCH}/ \
  && chmod -R u+x *.sh

if [[ -e release.json ]]; then
 echo -e "\n${ARCHIVE}::$(basename $0) release: $(grep FullSemVer release.json | awk -F\" '{print $4}')"
fi

PE_HOST=$(ncli cluster get-params \
  | grep 'External IP' \
  | awk -F: '{print $2}' \
  | tr -d '[:space:]')

echo -e "\nStarting stage_workshop.sh for ${EMAIL} with ${PRISM_ADMIN}:passwordNotShown@${PE_HOST} ...\n"

if [[ ! -z ${WORKSHOP} ]]; then
  echo -e "\tAdding workshop: ${WORKSHOP}"
  MY_WORKSHOP=" -w ${WORKSHOP}"
fi
   EMAIL=${EMAIL} \
    PE_HOST=${PE_HOST} \
PRISM_ADMIN=${PRISM_ADMIN} \
PE_PASSWORD=${PE_PASSWORD} \
./stage_workshop.sh -f - ${MY_WORKSHOP} # \
#  && popd || exit

echo -e "\n    DONE: ${0} ran for ${SECONDS} seconds."
cat <<EOM
Optional: Please consider running ${0} clean.

Watch progress with:
          tail -f *.log &
or login to PE to see tasks in flight and eventual PC registration:
          https://${PE_HOST}:9440/
EOM
