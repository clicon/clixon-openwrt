# Clixon openwrt wifi

How to (note package hash `794615` may change)
Host:
```
   make -j1 V=s package/clixon-wifi/compile
   scp bin/packages/x86_64/clixon/clixon-wifi_79461bead615ce4c549ad401bc33bb8a165c8494-1_x86_64.ipk
   ssh root@192.168.56.2
```

Target:
```
   (mkdir -p /usr/share/openconfig; cd /usr/share/openconfig; git clone https://github.com/openconfig/public)
   opkg install /tmp/clixon-wifi_79461bead615ce4c549ad401bc33bb8a165c8494-1_x86_64.ipk
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