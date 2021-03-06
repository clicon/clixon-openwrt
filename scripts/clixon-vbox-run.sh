#!/usr/bin/env bash
# Create a virtualbox for x86_64 and install openwrt + clixon and run a test
# Some effort has been made to make it generic using the TARGET/PROFILE variables but
# it may not make sense to run a virtualbox on anything else that x86-64-generic?
set -eux

# Set openwrt CONFIG_TARGET parameters according to make menuconfig
# Default is x86-64
: ${TARGET:=x86}
: ${SUBTARGET:=64}
: ${PROFILE:=generic}

# Where build is made
: ${builddir:=$(pwd)}
test -d ${builddir} || exit -1

# openwrt directory 
: ${openwrtdir:=${builddir}/openwrt}
test -d ${openwrtdir} || exit -1

: ${DISKSIZE:='512000000'}
: ${IMAGE:=openwrt-${TARGET}-${SUBTARGET}-${PROFILE}-ext4-combined.img}

sNAME=openwrt-${TARGET}-clixon
VDI="${sNAME}.vdi"
VMNAME="${sNAME}"
IMGC="${openwrtdir}/bin/targets/${TARGET}/${SUBTARGET}/${IMAGE}.gz"
IPADDR=192.168.1.1 # Default virtualbox host

function usage()
{
    echo "usage: $0"
    exit 255
}

if [ $# -ne 0 ]; then 
    usage
fi

cd ${openwrtdir}

VBoxManage controlvm ${VMNAME} poweroff || true
sleep 2
VBoxManage unregistervm --delete ${VMNAME} || true

VBoxManage createvm --name $VMNAME --register

VBoxManage modifyvm $VMNAME \
    --description "openwrt vbox" \
    --ostype "Linux26" \
    --memory "512" \
    --cpus "1" \
    --hostonlyadapter1="vboxnet0" \
    --nic1 "hostonly" \
    --nictype1 82540EM \
    --cableconnected1="on" \
    --macaddress2="08002730B510" \
    --cableconnected2="on" \
    --nic2="nat" \
    --nictype2="82540EM"

# Host side:
vboxmanage hostonlyif ipconfig vboxnet0 --ip 192.168.1.2

VBoxManage storagectl $VMNAME \
    --name "SATA Controller" \
    --add "sata" \
    --portcount "4" \
    --hostiocache "on" \
    --bootable "on" && \

rm -f ${VDI}
    
gunzip --stdout "${IMGC}" | VBoxManage convertfromraw --format VDI stdin "${VDI}" $DISKSIZE 

VBoxManage storageattach $VMNAME \
    --storagectl "SATA Controller" \
    --port "1" \
    --type "hdd" \
    --nonrotational "on" \
    --medium $VDI

VBoxManage startvm ${VMNAME} --type headless

ssh-keygen -R "${IPADDR}"

echo -n "Waiting for VM to boot"

ilimit=10
for (( i=1; i<${ilimit}; i++ )); do  
    echo -n "."
    sleep 1
    if [ $(ssh -o StrictHostKeyChecking=no root@${IPADDR} pwd > /dev/null 2>&1) ]; then
	break 	# OK, break loop
    fi
    # else error, continue loop and try again
done
# Timeout error
if [ ${i} -eq ${ilimit} ]; then
    echo Error
fi

cat<<EOF > ${builddir}/clixontest.sh
#!/usr/bin/env sh
set -eux
opkg update
opkg install git-http shadow-useradd
useradd -M -U clicon || true
useradd www-data -g clicon || true

# Always clone a new clixon
if [ -d clixon ]; then
   (cd clixon; git pull)
else
   git clone https://github.com/clicon/clixon.git
fi
# packages for clixon smoketest tests
opkg install curl coreutils-od sudo diffutils procps-ng-pkill bash
EOF

chmod 755 ${builddir}/clixontest.sh
scp -p -o StrictHostKeyChecking=no ${builddir}/clixontest.sh root@192.168.1.1:.
rm -f ${builddir}/clixontest.sh
ssh -o StrictHostKeyChecking=no root@192.168.1.1 ./clixontest.sh

cat<<EOF > ${builddir}/config.sh
YANG_INSTALLDIR=/usr/share/clixon
EOF
scp -p -o StrictHostKeyChecking=no ${builddir}/config.sh root@192.168.1.1:clixon/test/
rm -f ${builddir}/config.sh

# run test
ssh -o StrictHostKeyChecking=no root@192.168.1.1 "(cd clixon/test; ./test_helloworld.sh)"

# Close VM unless only run test
read -n 1 -p "Continue or ^C to keep VM?"

VBoxManage controlvm ${VMNAME} poweroff
sleep 2
VBoxManage unregistervm --delete ${VMNAME}

sleep 1 # ensure OK is last
echo OK


