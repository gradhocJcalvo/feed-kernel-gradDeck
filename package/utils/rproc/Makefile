#
# Copyright (C) 2025 Bootlin
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=rproc
PKG_RELEASE:=1

PKG_MAINTAINER:=Thomas Richard <thomas.richard@bootlin.com>

include $(INCLUDE_DIR)/package.mk

define Package/rproc
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Remote Processor utility
endef

define Pckage/rproc/description
  Remote Processor utility is responsible to set the firmware path, start and
  stop the remote processors.
endef

define Build/Compile
endef

define Package/rproc/conffiles
/etc/config/remoteproc
endef

define Package/rproc/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/init.d

	$(INSTALL_DATA) ./files/remoteproc.conf $(1)/etc/config/remoteproc
	$(INSTALL_BIN) ./files/rproc.init $(1)/etc/init.d/rproc
endef

$(eval $(call BuildPackage,rproc))
