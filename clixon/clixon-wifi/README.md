# Clixon openwrt wifi

## Description

Build an openconfig wifi clixon module 

Openconfig YANGs are from: [openconfig-wifi](https://github.com/openconfig/public/tree/master/release/models/wifi).

Clixon src code is from [clixon-examples wifi](https://github.com/clicon/clixon-examples/tree/master/wifi)

## Prereqs

An [openwrt buildroot](https://openwrt.org/docs/guide-developer/build-system/install-buildsystem) for your target machine.

Add the [clixon feed](../../README.md) and follow the instructions to setup and build the clixon feed and install cligen and clixon on target.

## Build

Host:
```
   make -j1 V=s package/clixon-wifi/compile
   scp bin/packages/x86_64/clixon/clixon-wifi_e8b68d6414a09a790fb2e05445c539b953790465-1_x86_64.ipk
   ssh root@192.168.56.2
```

Target:
```
   (mkdir -p /usr/share/openconfig; cd /usr/share/openconfig; git clone https://github.com/openconfig/public)
   opkg install /tmp/clixon-wifi_e8b68d6414a09a790fb2e05445c539b953790465-1_x86_64.ipk
   clixon_backend -f /etc/wifi.xml -s startup
   clixon_cli -f /etc/wifi.xml
   wifi /> ...
```

Host:
```
   curl -X GET  --http2-prior-knowledge -Ssik http://192.168.56.2:8080/restconf/data
   HTTP/2 200 
content-type: application/yang-data+json
cache-control: no-cache
content-length: 985

{
  "data": {
    "openconfig-system:system": {
    ...
```

Note package hash `e8b68d` may change
