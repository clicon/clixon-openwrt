#
# Copyright (C) 2020-2022 Olof Hagsand and Rubicon Communications, LLC(Netgate)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

# Name, version and release number
PKG_NAME:=cligen
# Upstream version
PKG_VERSION:=6.3.0
# Version of package itself
PKG_RELEASE:=1
PKG_MAINTAINER:=Olof Hagsand <olof@hagsand.se>

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/clicon/cligen.git
PKG_HASH:=71781c8f7923659b6d1dd276686949e0c099797e938337e68e8dd84931981c1d
PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)

# Call original “make install” with prefix set to PKG_INSTALL_DIR
PKG_INSTALL:=1

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

# Don't strip on arm/bcm/pi (INSTALLFLAGS="")
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
	$(CP) $(PKG_INSTALL_DIR)/usr/include/cligen $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libcligen.so* $(1)/usr/lib/
endef

define Package/cligen/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libcligen.so* $(1)/usr/lib/
endef

# This command is always the last, it uses the definitions and variables we give above in order to get the job done
$(eval $(call BuildPackage,cligen))
