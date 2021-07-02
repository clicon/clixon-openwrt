include $(TOPDIR)/rules.mk

# Name, version and release number
PKG_NAME:=clixon
PKG_VERSION:=5.2
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/clicon/clixon.git
PKG_HASH:=skip
#PKG_HASH:=0ea338710e0ab8524842d7da076a0a1040b8c74029ace859d4b3cdacb8d51c3d
#PKG_MIRROR_HASH:=0ea338710e0ab8524842d7da076a0a1040b8c74029ace859d4b3cdacb8d51c3d
PKG_SOURCE_VERSION:=ef131cf407e72df26e4e19e9f0b2ad39ae409e98

PKG_MAINTAINER:=Olof Hagsand <olof@hagsand.se>

PKG_LICENSE_FILES:=LICENSE.md

PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_SOURCE_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)

# This is build/devel dependencies
PKG_BUILD_DEPENDS:=cligen
#libopenssl libnghttp2

include $(INCLUDE_DIR)/package.mk

# Package definition; instructs on how and where our package will appear in the overall configuration menu ('make menuconfig')
define Package/clixon
  SECTION:=utils
  CATEGORY:=Utilities
  URL:=http://www.clixon.org
  TITLE:=YANG-based toolchain
  DEPENDS:=+cligen +libopenssl +libnghttp2
# +libclixon.so +libclixon_backend.so +libclixon_cli.so +libclixon_netconf.so +libclixon_restconf.so
#  DEPENDS:=+zlib +libopenssl +libpthread
endef

# Package description; a more verbose description on what our package does
define Package/clixon/description
	YANG-based toolchain including NETCONF and RESTCONF interfaces and an interactive CLI 
endef

#/home/olof/syssrc/openwrt/staging_dir/target-x86_64_musl/root-x86/usr
# sudo ln -s libcligen.so.5.1 libcligen.so
# BUILD_DIR: /home/olof/syssrc/openwrt/build_dir/target-x86_64_musl
define Build/Configure
#	(cd $(BUILD_DIR)/cligen-5.1.0/ipkg-x86_64/cligen/usr/lib; ln -s libcligen.so.$(PKG_VERSION) libcligen.so)
	CPPFLAGS="-I/home/olof/syssrc/openwrt/staging_dir/target-x86_64_musl/root-x86/usr/include ${CPPFLAGS}"
#	$(call Build/Configure/Default, --with-restconf=native --disable-evhtp)
	$(call Build/Configure/Default, --with-restconf=native --disable-evhtp --with-cligen=/home/olof/syssrc/openwrt/staging_dir/target-x86_64_musl/root-x86/usr)
endef

define Build/Compile
	$(call Build/Compile/Default)
	(cd $(PKG_BUILD_DIR)/lib/src; test -h libclixon.so.5 || ln -s libclixon.so.$(PKG_VERSION) libclixon.so.5)
	(cd $(PKG_BUILD_DIR)/apps/backend; test -h libclixon_backend.so.5 || ln -s libclixon_backend.so.$(PKG_VERSION) libclixon_backend.so.5)
	(cd $(PKG_BUILD_DIR)/apps/restconf; test -h libclixon_restconf.so.5 || ln -s libclixon_restconf.so.$(PKG_VERSION) libclixon_restconf.so.5)
	(cd $(PKG_BUILD_DIR)/apps/netconf; test -h libclixon_netconf.so.5 || ln -s libclixon_netconf.so.$(PKG_VERSION) libclixon_netconf.so.5)
	(cd $(PKG_BUILD_DIR)/apps/cli; test -h libclixon_cli.so.5 || ln -s libclixon_cli.so.$(PKG_VERSION) libclixon_cli.so.5)
endef

define Package/clixon/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/apps/backend/clixon_backend $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/apps/restconf/clixon_restconf $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/apps/cli/clixon_cli $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/apps/netconf/clixon_netconf $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/src/libclixon.so.$(PKG_VERSION) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/src/libclixon.so.5 $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/apps/backend/libclixon_backend.so.$(PKG_VERSION) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/apps/backend/libclixon_backend.so.5 $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/apps/restconf/libclixon_restconf.so.$(PKG_VERSION) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/apps/restconf/libclixon_restconf.so.5 $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/apps/netconf/libclixon_netconf.so.$(PKG_VERSION) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/apps/netconf/libclixon_netconf.so.5 $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/apps/cli/libclixon_cli.so.$(PKG_VERSION) $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/apps/cli/libclixon_cli.so.5 $(1)/usr/lib/
endef

# This command is always the last, it uses the definitions and variables we give above in order to get the job done
$(eval $(call BuildPackage,clixon))
