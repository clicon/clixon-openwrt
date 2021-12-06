<div align="center">
  <img src="https://www.clicon.org/Clixon_logga_liggande_med-ikon.png" width="400">
</div>

# Clixon openwrt feed

## Description

This repo contains an OpenWrt package feed containing clixon related libraries and applications.

Note: clixon restconf is configured as native http/2-only

## Prereqs

You need a target system. One way is to use [virtualbox](https://openwrt.org/docs/guide-user/virtualization/virtualbox-vm)

Then you need to setup an openwrt cross-compile environment:

* Checkout openwrt: `git://github.com/openwrt/openwrt.git
* Setup an [openwrt buildroot](https://openwrt.org/docs/guide-developer/toolchain/crosscompile) for cross-compiling

## Building

To use the clixon packages, add the following line to feeds.conf in the OpenWrt buildroot. If feeds.conf does not exist, create it::

   src-git clixon https://github.com/clicon/clixon-openwrt.git

The clixon-openwrt feed should be included and enabled by default in the OpenWrt buildroot. To install all its package definitions, run:
```
  ./scripts/feeds update clixon
  ./scripts/feeds install -a -p clixon
```

You may also need to add:
```
  src-git packages https://git.openwrt.org/feed/packages.git
```

Run `make menuconfig` and check the clixon packages in the section 'Utilities', and save.

To build a basic clixon system on a given openwrt root build:
```
  make -j1 V=s package/cligen/compile
  make -j1 V=s package/clixon/compile
```

## Install

Thereafter the packages are copied to the target machine and installed

```
  scp bin/packages/x86_64/clixon/cligen_5.2.0-1_x86_64.ipk root@192.168.56.2:/tmp/
  scp bin/packages/x86_64/clixon/clixon_5.2.0-1_x86_64.ipk root@192.168.56.2:/tmp/
```

Login to the target and install the packages:
```
  ssh root@192.168.56.2
  opkg update
  opkg install /tmp/cligen_5.2.0-1_x86_64.ipk
  opkg install /tmp/clixon_5.2.0-1_x86_64.ipk
```

At this point, a base clixon libs and data files are installed and you can proceed to install a clixon example or application, such as hello world:

```
  make -j1 V=s package/clixon-hello/compile
  scp bin/packages/x86_64/clixon/clixon-hello*_x86_64.ipk root@192.168.56.2:/tmp/
  opkg install /tmp/clixon-helloxxx_x86_64.ipk
```
where `xxx` is the version.

Thereafter the clixon eample can run, eg:
```
  clixon_backend -f /etc/hello.xml
```

