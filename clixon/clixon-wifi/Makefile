#
# Copyright (C) 2020-2021 Olof Hagsand and Rubicon Communications, LLC(Netgate)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

# Name, version and release number
PKG_NAME:=clixon-wifi
# Upstrean version
PKG_VERSION:=4617bfb47a3ac1010fe15ff226ad0a699efb0a01
# Version of packet itself
PKG_RELEASE:=1
PKG_MAINTAINER:=Olof Hagsand <olof@hagsand.se>

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/clicon/clixon-examples.git
PKG_HASH:=77d2f1d2b94a829fa90f9b9c5f3b3faa70218396d11e7c9dd1e26ee53a4630c2
PKG_MIRROR_HASH:=77d2f1d2b94a829fa90f9b9c5f3b3faa70218396d11e7c9dd1e26ee53a4630c2

PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)

# Call original “make install” with prefix set to PKG_INSTALL_DIR
PKG_INSTALL:=1

# This is build/devel dependencies
PKG_BUILD_DEPENDS:=cligen clixon

include $(INCLUDE_DIR)/package.mk

# Package definition; instructs on how and where our package will appear in the overall configuration menu ('make menuconfig')
define Package/clixon-wifi
	SECTION:=utils
	CATEGORY:=Utilities
	URL:=http://www.clixon.org
	TITLE:=Clixon openconfig wifi application
#	DEPENDS:=+clixon
endef

# Package description; a more verbose description on what our package does
define Package/clixon-wifi/description
	Clixon openconfig wifi application
endef

CONFIGURE_ARGS += --with-cligen=$(STAGING_DIR_ROOT)/usr --with-clixon=$(STAGING_DIR_ROOT)/usr
define Build/Configure
	$(call Build/Configure/Default)
endef

# Check out all example but build only wifi
MAKE_PATH:=wifi/src
define Build/Compile
	$(call Build/Compile/Default, DESTDIR="$(PKG_INSTALL_DIR)")
endef

define Package/clixon-wifi/install
	# wifi.xml needs path patch /usr/local -> /usr/
	sed -i -e 's/\/usr\/local\/etc\/wifi.xml/\/etc\/wifi.xml/g' $(PKG_INSTALL_DIR)/etc/wifi.xml
	sed -i -e 's/\/usr\/local\//\/usr\//g' $(PKG_INSTALL_DIR)/etc/wifi.xml
	sed -i -e 's/<CLICON_SOCK_GROUP>clicon/<CLICON_SOCK_GROUP>root/g' $(PKG_INSTALL_DIR)/etc/wifi.xml
	sed -i -e 's/<CLICON_RESTCONF_USER>www-data/<CLICON_RESTCONF_USER>root/g' $(PKG_INSTALL_DIR)/etc/wifi.xml
	sed -i -e 's/<CLICON_RESTCONF_PRIVILEGES>drop_perm/<CLICON_RESTCONF_PRIVILEGES>none/g' $(PKG_INSTALL_DIR)/etc/wifi.xml
	sed -i -e 's/<port>80<\/port>/<port>8080<\/port>/g' $(PKG_INSTALL_DIR)/var/wifi/startup_db
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/*.xml $(1)/etc/
	$(INSTALL_DIR) $(1)/usr/lib/wifi/clispec
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/wifi/clispec/*.cli $(1)/usr/lib/wifi/clispec/
	$(INSTALL_DIR) $(1)/usr/share/clixon
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/share/clixon/*.yang $(1)/usr/share/clixon/
	# Cant install dir into $(1)/var/wifi
	$(INSTALL_DIR) $(1)/usr/var/wifi
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/var/wifi/startup_db $(1)/usr/var/wifi/
endef

# This command is always the last, it uses the definitions and variables we give above in order to get the job done
$(eval $(call BuildPackage,clixon-wifi))
