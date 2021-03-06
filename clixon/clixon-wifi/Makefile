#
# Copyright (C) 2020-2022 Olof Hagsand and Rubicon Communications, LLC(Netgate)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

# Name, version and release number
PKG_NAME:=clixon-wifi
# Upstrean version
PKG_VERSION:=HEAD
# Version of packet itself
PKG_RELEASE:=1
PKG_MAINTAINER:=Olof Hagsand <olof@hagsand.se>

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/clicon/clixon-examples.git

PKG_HASH:=779e95880edd78f262989c4b0501b88f84b25d9d49a5e2112d5d71423cf8429c
# Set to skip and run check FIXUP=1
#PKG_MIRROR_HASH:=skip

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
	DEPENDS:=+clixon
endef

# Package description; a more verbose description on what our package does
define Package/clixon-wifi/description
	Clixon openconfig wifi application
endef

CONFIGURE_ARGS += --with-cligen=$(STAGING_DIR_ROOT)/usr --with-clixon=$(STAGING_DIR_ROOT)/usr
# Dont strip on arm/bcm/pi (INSTALLFLAGS="")
define Build/Configure
	$(call Build/Configure/Default, INSTALLFLAGS="")
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
	$(INSTALL_DIR) $(1)/usr/lib/wifi/backend
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/wifi/backend/*.so $(1)/usr/lib/wifi/backend/
	$(INSTALL_DIR) $(1)/usr/share/clixon
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/share/clixon/*.yang $(1)/usr/share/clixon/
	# Cant install dir into $(1)/var/wifi
	$(INSTALL_DIR) $(1)/usr/var/wifi
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/var/wifi/startup_db $(1)/usr/var/wifi/
endef

# This command is always the last, it uses the definitions and variables we give above in order to get the job done
$(eval $(call BuildPackage,clixon-wifi))
