**Note:** This is still in work and not production ready!

# PAC Protocol Masternode Docker Edition

## PAC Protocol Used:
- PAC Protocol v0.17.4

## Features
- Auto-Setup, you just need to enter bls private key and IP address - thats all
- Sentinel included
- Auto-Bootstrap Downloader for fresh start
- Check all 1 hours for local blockchain. If corrupted, reindex it.


## How to tun

1. Install docker
2. Build docker by using `build.sh`
3. Run docker by using `run.sh`

Note to running docker - you can set your own `MNKEY` and `IPADDR` at `-e` enviroment variable:

```bash
docker run -it \
    --name pacprotocol-mn \
    --mount type=bind,source=$workdir/mount/PACProtocol,target=/PACProtocol \
    -p 7112:7112 \
    -p 7111:7111 \
    --memory="2g" \
    --memory-swap="8g" \
    -e MNKEY='<mnkey>' \
    -e IPADDR='<ip-address>' \
    pacprotocol-mn
```
