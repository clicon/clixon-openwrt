# Clixon openwrt test scripts

This dir contains test scripts for running clixon in openwrt. The script has been run on Ubuntu 18
   * clixon-openwrt-build.sh    Checkout, build, install and test Clixon HEAD on VM
   * clixon-vbox-run.sh:    Start a virtualbox and install openwrt and test the hello application

Build openwrt on x86-64 with cligen and clixon base package:
```
git clone https://github.com/openwrt/openwrt.git
./clixon-openwrt-build.sh
```

Create a virtualbox, install the image and run a simple test script:
```
./clixon-vbox-run.sh
...
Continue or ^C to keep VM?^C
```
