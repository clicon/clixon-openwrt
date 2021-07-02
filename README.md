<div align="center">
  <img src="https://www.clicon.org/Clixon_logga_liggande_med-ikon.png" width="400">
</div>

# Clixon openwrt feed

## Description

This repo contains an OpenWrt package feed containing clixon related libraries and applications.

## Prereqs

For building, you need an [openwrt buildroot](https://openwrt.org/docs/guide-developer/build-system/install-buildsystem) for your target machine.

## Building

To use these packages, add the following line to feeds.conf in the OpenWrt buildroot:

```
src-git clixon https://github.com/clicon/openwrt-feed.git
```

This feed should be included and enabled by default in the OpenWrt buildroot. To install all its package definitions, run:

```
./scripts/feeds update clixon
./scripts/feeds install -a -p clixon
```

The clixon packages should now appear in menuconfig in section 'Utilities'.

To build and install cligen on a target x86_64 machine:
```
make -j1 V=s package/cligen/compile
scp bin/packages/x86_64/clixon/cligen_5.2.0-1_x86_64.ipk root@192.168.56.2:/tmp/
ssh root@192.168.56.2
opkg install /tmp/cligen_5.2.0-1_x86_64.ipk
```

Other clixon packages are built and installed in a similar way (just replace "cligen" with the package you want to build).
