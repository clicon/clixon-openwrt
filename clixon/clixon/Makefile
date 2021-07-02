#
# Copyright (C) 2020-2021 Olof Hagsand and Rubicon Communications, LLC(Netgate)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

# Name, version and release number
PKG_NAME:=clixon
# Upstrean version
PKG_VERSION:=5.2.0
# Version of packet itself
PKG_RELEASE:=1
PKG_MAINTAINER:=Olof Hagsand <olof@hagsand.se>

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/clicon/clixon.git
PKG_HASH:=39fdcd11b4fb3e895123ffcba8772fd45fe59851589a63dc0e5ce0c3acdb1403
#PKG_MIRROR_HASH:=

PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)

# Call original “make install” with prefix set to PKG_INSTALL_DIR
PKG_INSTALL:=1

# This is build/devel dependencies
PKG_BUILD_DEPENDS:=cligen nghttp2 openssl

include $(INCLUDE_DIR)/package.mk

# Package definition; instructs on how and where our package will appear in the overall configuration menu ('make menuconfig')
define Package/clixon
	SECTION:=utils
	CATEGORY:=Utilities
	URL:=http://www.clixon.org
	TITLE:=YANG-based toolchain
	DEPENDS:=+cligen +libopenssl +libnghttp2
endef

# Package description; a more verbose description on what our package does
define Package/clixon/description
	YANG-based toolchain including NETCONF and RESTCONF interfaces and an interactive CLI 
endef

CONFIGURE_ARGS += --with-restconf=native --disable-evhtp --with-cligen=$(STAGING_DIR_ROOT)/usr
define Build/Configure
	$(call Build/Configure/Default)
endef

define Build/Compile
	$(call Build/Compile/Default, DESTDIR="$(PKG_INSTALL_DIR)"))
endef

# Source packages defining binary packages that ship shared libraries should declare a Build/InstallDev
# recipe that copies all resources required to discover and link the shared libraries into the staging
# directory. 
define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/lib/src/libclixon.so* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/apps/backend/libclixon_backend.so* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/apps/restconf/libclixon_restconf.so* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/apps/netconf/libclixon_netconf.so* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/apps/cli/libclixon_cli.so* $(1)/usr/lib/
endef

define Package/clixon/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/clixon_backend $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/clixon_restconf $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/usr/bin/clixon_cli $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/usr/bin/clixon_netconf $(1)/usr/bin/
	$(CP) $(PKG_INSTALL_DIR)/lib/src/libclixon.so* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/apps/backend/libclixon_backend.so* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/apps/restconf/libclixon_restconf.so* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/apps/netconf/libclixon_netconf.so* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/apps/cli/libclixon_cli.so* $(1)/usr/lib/
endef

# This command is always the last, it uses the definitions and variables we give above in order to get the job done
$(eval $(call BuildPackage,clixon))
