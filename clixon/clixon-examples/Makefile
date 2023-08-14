#
# Copyright (C) 2020-2021, 2023 Olof Hagsand and Rubicon Communications, LLC(Netgate)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

# Name, version and release number
PKG_NAME:=clixon-examples
# Upstream version
PKG_VERSION:=HEAD
# Version of package itself
PKG_RELEASE:=1
PKG_MAINTAINER:=Olof Hagsand <olof@hagsand.se>

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/clicon/clixon-examples.git
PKG_HASH:=77d2f1d2b94a829fa90f9b9c5f3b3faa70218396d11e7c9dd1e26ee53a4630c2
# set to skip and then make -j1 V=s package/cligen/check FIXUP=1:
#PKG_MIRROR_HASH:=skip

PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)

# Call original “make install” with prefix set to PKG_INSTALL_DIR
PKG_INSTALL:=1

# This is build/devel dependencies
PKG_BUILD_DEPENDS:=cligen clixon

include $(INCLUDE_DIR)/package.mk

define Package/clixon-examples/Default
	SECTION:=utils
	CATEGORY:=Utilities
	URL:=http://www.clixon.org
	DEPENDS:=+clixon
endef

define Package/clixon-hello
	$(call Package/clixon-examples/Default)
	TITLE:=Clixon hello world example
endef

define Package/clixon-hello/description
	Simple hello world application
endef

define Package/clixon-wifi
	$(call Package/clixon-examples/Default)
	TITLE:=Clixon wifi example
endef

define Package/clixon-wifi/description
	Simple wifi application
endef

define Package/clixon-openconfig
	$(call Package/clixon-examples/Default)
	TITLE:=Clixon openconfig example
endef

define Package/clixon-openconfig/description
	Simple openconfig application
endef

CONFIGURE_ARGS+=\
		--localstatedir=/usr/var \
		--with-clicon-user=clicon \
		--with-clicon-group=clicon

CONFIGURE_ARGS:=$(filter-out --disable-dependency-tracking,$(CONFIGURE_ARGS))

# Check out all examples but build only hello
define Build/Compile
	$(call Build/Compile/Default, DESTDIR="$(PKG_INSTALL_DIR)")
endef

define Package/clixon-hello/install
	$(INSTALL_DIR) $(1)/etc/clixon/ $(1)/etc/clixon/hello
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/clixon/hello.xml $(1)/etc/clixon
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/clixon/hello/{autocli,restconf}.xml $(1)/etc/clixon/hello
	$(INSTALL_DIR) $(1)/usr/lib/hello/clispec
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/hello/clispec/*.cli $(1)/usr/lib/hello/clispec/
	$(INSTALL_DIR) $(1)/usr/share/clixon
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/share/clixon/clixon-hello@*.yang $(1)/usr/share/clixon/
	# Cant install dir into $(1)/var/hello
	$(INSTALL_DIR) $(1)/usr/var/hello
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/var/hello/startup_db $(1)/usr/var/hello/
endef

define Package/clixon-hello/conffiles
/etc/clixon/hello.xml
/etc/clixon/hello/
endef

define Package/clixon-wifi/install
	$(INSTALL_DIR) $(1)/etc/clixon/ $(1)/etc/clixon/wifi
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/clixon/wifi.xml $(1)/etc/clixon
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/clixon/wifi/autocli.xml $(1)/etc/clixon/wifi
	$(INSTALL_DIR) $(1)/usr/lib/wifi/clispec
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/wifi/clispec/*.cli $(1)/usr/lib/wifi/clispec/
	$(INSTALL_DIR) $(1)/usr/share/clixon
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/share/clixon/clixon-wifi@*.yang $(1)/usr/share/clixon/
	# Cant install dir into $(1)/var/wifi
	$(INSTALL_DIR) $(1)/usr/var/wifi
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/var/wifi/startup_db $(1)/usr/var/wifi/
endef

define Package/clixon-wifi/conffiles
/etc/clixon/wifi.xml
/etc/clixon/wifi/
endef

define Package/clixon-openconfig/install
	$(INSTALL_DIR) $(1)/etc/clixon/ $(1)/etc/clixon/openconfig
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/clixon/openconfig.xml $(1)/etc/clixon
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/clixon/openconfig/autocli.xml $(1)/etc/clixon/openconfig
	$(INSTALL_DIR) $(1)/usr/lib/openconfig/clispec
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/openconfig/clispec/*.cli $(1)/usr/lib/openconfig/clispec/
	$(INSTALL_DIR) $(1)/usr/share/clixon
	# $(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/share/clixon/clixon-openconfig@*.yang $(1)/usr/share/clixon/
	# Cant install dir into $(1)/var/openconfig
	$(INSTALL_DIR) $(1)/usr/var/openconfig
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/var/openconfig/startup_db $(1)/usr/var/openconfig/
endef

define Package/clixon-openconfig/conffiles
/etc/clixon/openconfig.xml
/etc/clixon/openconfig/
endef

# This command is always the last, it uses the definitions and variables we give above in order to get the job done
$(eval $(call BuildPackage,clixon-hello))
$(eval $(call BuildPackage,clixon-wifi))
$(eval $(call BuildPackage,clixon-openconfig))
