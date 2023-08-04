#
# Copyright (C) 2020-2022 Olof Hagsand and Rubicon Communications, LLC(Netgate)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

# Name, version and release number
PKG_NAME:=clixon
# Upstream version
PKG_VERSION:=6.3.0
# Version of package itself
PKG_RELEASE:=1
PKG_MAINTAINER:=Olof Hagsand <olof@hagsand.se>

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/clicon/clixon.git
PKG_HASH:=fdfe646dc9128483acde8ce1c8968f8224ae5db3fdee727fc70db2366941e27b

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
	DEPENDS:=+cligen +libopenssl +libnghttp2 +libcurl
endef

# Package description; a more verbose description on what our package does
define Package/clixon/description
	YANG-based toolchain including NETCONF and RESTCONF interfaces and an interactive CLI 
endef

CONFIGURE_ARGS += \
	--with-restconf=native \
	--with-configfile=/etc/clixon.xml

CONFIGURE_ARGS:=$(filter-out --disable-dependency-tracking,$(CONFIGURE_ARGS))

define Build/Configure
	$(call Build/Configure/Default, INSTALLFLAGS="")
endef

define Build/Compile
	$(call Build/Compile/Default, DESTDIR="$(PKG_INSTALL_DIR)")
endef

# Source packages defining binary packages that ship shared libraries should declare a Build/InstallDev
# recipe that copies all resources required to discover and link the shared libraries into the staging
# directory. 
define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/clixon $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libclixon.so* \
	      $(PKG_INSTALL_DIR)/usr/lib/libclixon_backend.so* \
	      $(PKG_INSTALL_DIR)/usr/lib/libclixon_restconf.so* \
	      $(PKG_INSTALL_DIR)/usr/lib/libclixon_cli.so* \
	      $(1)/usr/lib/
endef

define Package/clixon/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/clixon_* $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/clixon_* $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/usr/share/clixon
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/share/clixon/*.yang $(1)/usr/share/clixon/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libclixon.so* \
	      $(PKG_INSTALL_DIR)/usr/lib/libclixon_backend.so* \
	      $(PKG_INSTALL_DIR)/usr/lib/libclixon_restconf.so* \
	      $(PKG_INSTALL_DIR)/usr/lib/libclixon_cli.so* \
	      $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/clixon $(1)/etc/init.d/clixon
endef

# This command is always the last, it uses the definitions and variables we give above in order to get the job done
$(eval $(call BuildPackage,clixon))

