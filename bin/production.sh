#!/bin/sh

DIR="$(cd "$(dirname "$0")" && pwd)"

## Guard against empty $DIR
if [[ "$DIR" != */bin ]]; then
    echo "Could not detect working directory."
    exit 1
fi

cd "${DIR}/../" || exit

if [ -r docker-compose.override.yml ]
then
    ADDITIONAL="-f docker-compose.override.yml"
else
    ADDITIONAL=""
fi

docker_compose="docker-compose"
if ! command -v ${docker_compose} &> /dev/null
then
    docker_compose="docker compose"
fi  

${docker_compose} \
  -f docker-compose.yml \
  -f docker-compose.production.yml \
  ${ADDITIONAL} \
  "$@"
