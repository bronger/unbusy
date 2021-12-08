#!/bin/sh
set -e

SCRIPT=$(realpath -e "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH

docker build --pull -t bronger/unbusy .
docker push bronger/unbusy
