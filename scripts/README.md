# Clixon openwrt test scripts

This dir contains test scripts for running clixon in openwrt. The script has been run on Ubuntu 18
     - test_clixon_openwrt.sh      checkout, build, install and test Clixon HEAD on VM
     - test_clixon_openwrt_wifi.sh checkout, build, install and test Clixon WIFI app on VM

Build wifi module:
```
make package/wifi/download
make package/wifi/check V=s FIXUP=1
make -j1 V=s package/wifi/compile
```

Copy and install:
```
scp bin/packages/x86_64/local/wifi_HEAD-1_x86_64.ipk root@192.168.1.1:/tmp
ssh root@192.168.1.1
root@OpenWrt:~# opkg install /tmp/cligen_5.2.0-1_x86_64.ipk
```

Run:
```
clixon_backend -f /etc/wifi.xml
```
