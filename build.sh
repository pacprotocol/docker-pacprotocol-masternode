#!/bin/bash

docker rm -f pacprotocol-mn && \
docker build \
    --progress=plain \
    --compress \
    -t pacprotocol-mn .