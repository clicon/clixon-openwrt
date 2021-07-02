<div align="center">
  <img src="https://www.clicon.org/Clixon_logga_liggande_med-ikon.png" width="400">
</div>

# Clixon openwrt feed

## Description

This repo contains an OpenWrt package feed containing clixon related libraries and applications.

## Usage

To use these packages, add the following line to the feeds.conf
in the OpenWrt buildroot:

```
src-git clixon https://github.com/clixon/openwrt-feed.git
```

This feed should be included and enabled by default in the OpenWrt buildroot. To install all its package definitions, run:

```
./scripts/feeds update clixon
./scripts/feeds install -a -p clixon
```

The clixon packages should now appear in menuconfig in section 'utils'.
