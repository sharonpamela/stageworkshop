# shellcheck disable=SC2148
#  Note: hooks/pre-commit/01-release symlinks here
# Debug: bash -x hooks/scripts/semver_release.sh

CONTAINER_TAG='gittools/gitversion-fullfx:linux-4.0.0'
# works on LinuxMint

pushd ~/Documents/github.com/mlavi/stageworkshop/ \
&& source scripts/lib.shell-convenience.sh 'quiet' || exit 1

if (( $(docker ps 2>&1 | grep Cannot | wc --lines) == 0 )); then
  docker run --rm -v "$(pwd):/repo" ${CONTAINER_TAG} /repo \
  > ${RELEASE}
elif [[ ! -z $(which gitversion) ]]; then
  gitversion > ${RELEASE}
else
  ERROR=10
  echo "Error ${ERROR}: Docker engine down and no native binary available on PATH."
  exit ${ERROR}
fi

rm -f original.${RELEASE} || true
mv ${RELEASE} original.${RELEASE} && cat ${_} \
| jq ". + {\"PrismCentralStable\":\"${PC_STABLE_VERSION}\"} + {\"PrismCentralDev\":\"${PC_DEV_VERSION}\"}" \
> ${RELEASE} && rm -f original.${RELEASE}

git add ${RELEASE}
