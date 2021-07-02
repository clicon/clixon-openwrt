#
# Copyright (C) 2020-2021 Olof Hagsand and Rubicon Communications, LLC(Netgate)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

# Name, version and release number
PKG_NAME:=cligen
# Upstrean version
PKG_VERSION:=5.2.0
# Version of packet itself
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/clicon/cligen.git
PKG_HASH:=skip
#PKG_HASH:=9488d3a61df244f9bfcac49ac64298940f57a769e0a957c5e563b708968591bd
PKG_MIRROR_HASH:=skip
#PKG_SOURCE_VERSION:=5.2.0

PKG_MAINTAINER:=Olof Hagsand <olof@hagsand.se>

#PKG_LICENSE_FILES:=LICENSE.md

PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)

include $(INCLUDE_DIR)/package.mk

# Package definition; instructs on how and where our package will appear in the overall configuration menu ('make menuconfig')
define Package/cligen
	SECTION:=utils
	CATEGORY:=Utilities
	URL:=http://www.cligen.se
	TITLE:=CLIgen is a Command-Line Interface generator 
endef

# Package description; a more verbose description on what our package does
define Package/cligen/description
	CLIgen is a Command-Line Interface generator 
endef

define Build/Configure
	$(call Build/Configure/Default)
endef

define Build/Compile
	$(call Build/Compile/Default, DESTDIR="$(PKG_INSTALL_DIR)")
#	(cd $(PKG_BUILD_DIR); test -h libcligen.so || ln -s libcligen.so.$(PKG_VERSION) libcligen.so)
endef

# Source packages defining binary packages that ship shared libraries should declare a Build/InstallDev
# recipe that copies all resources required to discover and link the shared libraries into the staging
# directory. 
define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/cligen
	$(CP) $(PKG_INSTALL_DIR)/cligen*.h $(1)/usr/include/cligen/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libcligen.{a,so*} $(1)/usr/lib/
endef

#define Package/cligen/install
#	$(INSTALL_DIR) $(1)/usr/lib
#	$(CP) $(PKG_BUILD_DIR)/libcligen.so* $(1)/usr/lib/
#endef

# This command is always the last, it uses the definitions and variables we give above in order to get the job done
$(eval $(call BuildPackage,cligen))
