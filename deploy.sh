#!/bin/sh
set -e
set -x

export NAME=$(jq -r .name version.json)
export VERSION=$(jq -r .version version.json)
export HASH=$(git rev-parse --short HEAD)
export REGISTRY_NAMESPACE="translatednet"

DOCKER_BUILDKIT=1 docker build --force-rm --no-cache --tag "$NAME" --network=host .

IMAGE="$REGISTRY_NAMESPACE/$NAME:$VERSION"
echo Deploying "$IMAGE" on production
docker tag "$NAME" "$IMAGE"
docker push "$IMAGE"
DOCKER_HOST="ssh://root@tesla.translated.com:2222" IMAGE="$IMAGE" docker stack deploy --with-registry-auth -c docker-compose.production.yml "$NAME"
