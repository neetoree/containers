#!/usr/bin/env bash
set -e
docker build --force-rm -t neetoree.org/${1///} $1
docker push neetoree.org/${1///}
