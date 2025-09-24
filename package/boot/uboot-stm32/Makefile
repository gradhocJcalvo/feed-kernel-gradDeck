#
# Copyright (C) 2024 Bootlin
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_VERSION:=ev1-build
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/gradhocJcalvo/u-boot-graddeck.git
PKG_SOURCE_VERSION:=ev1-build
PKG_MIRROR_HASH:=6269b95a15861163838d92bb9181aff35588c9a2
PKG_MAINTAINER:=Angel Eimil <aeimil@gradhoc.com> Javier Calvo <jcalvo@gradhoc.com>

UBOOT_USE_INTREE_DTC:=1

include $(INCLUDE_DIR)/u-boot.mk
include $(INCLUDE_DIR)/package.mk

define U-Boot/Default
  BUILD_TARGET:=stm32
  UBOOT_IMAGE:=u-boot.bin u-boot.dtb
endef

define U-Boot/stm32mp25
  BUILD_SUBTARGET:=stm32mp2
  UBOOT_CONFIG:=stm32mp25
endef

define U-Boot/stm32mp257f-ev1
  $(call U-Boot/stm32mp25)
  NAME:=STM32MP257F-EV1
  DEVICE_TREE:=stm32mp257f-ev1
endef

UBOOT_TARGETS :=stm32mp257f-ev1

UBOOT_MAKE_FLAGS += DEVICE_TREE=$(DEVICE_TREE)

define Build/InstallDev
	$(INSTALL_DIR) $(STAGING_DIR_IMAGE)
	$(foreach img,$(UBOOT_IMAGE), \
		$(CP) $(PKG_BUILD_DIR)/$(img) $(STAGING_DIR_IMAGE)/$(BUILD_VARIANT)-$(img); \
	)
endef

define Package/u-boot/install/default
endef

$(eval $(call BuildPackage/U-Boot))
