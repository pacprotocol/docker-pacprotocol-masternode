#!/bin/bash

# MNKEY and IPADDRE are example and not being used.

docker run -it \
    --name pacprotocol-mn \
    --mount type=bind,source=$(pwd)/mount/PACProtocol,target=/PACProtocol \
    -p 7112:7112 \
    -p 7111:7111 \
    --memory="2g" \
    --memory-swap="8g" \
    -e MNKEY='59e79026756754bb532d2e8d5766166b4671011420c169981d7758a5abe263ba' \
    -e IPADDR='222.23.112.49' \
    pacprotocol-mn