#
# Copyright (C) 2024 Bootlin
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_VERSION:=main
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/gradhocJcalvo/optee-graddeck.git
PKG_SOURCE_VERSION:=main
PKG_MIRROR_HASH:=8a4721305a0048af964869795c1cf2e24dbe3926
PKG_MAINTAINER:=Angel Eimil <aeimil@gradhoc.com> Javier Calvo <jcalvo@gradhoc.com>

OPTEE_USE_INTREE_DTC:=1

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/optee-os.mk
include $(INCLUDE_DIR)/package.mk

define Optee-os/Default
  BUILD_TARGET:=stm32
endef

define Optee-os/stm32mp2
  BUILD_SUBTARGET:=stm32mp2
  PLAT:=stm32mp2
  OPTEE_MAKE_FLAGS += CFG_SCMI_SCPFW=y
endef

define Optee-os/stm32mp257f-ev1
  $(call Optee-os/stm32mp2)
  NAME:=STM32MP257F-EV1
  OPTEE_MAKE_FLAGS += CFG_EMBED_DTB_SOURCE_FILE=stm32mp257f-ev1.dts
endef

OPTEE_TARGETS := stm32mp257f-ev1 

define Package/optee-os/install/default
endef

define Build/InstallDev
	$(INSTALL_DIR) $(STAGING_DIR_IMAGE)
	$(foreach img,$(OPTEE_IMAGE), \
		$(CP) $(PKG_BUILD_DIR)/out/arm-plat-$(PLAT)/core/$(img) $(STAGING_DIR_IMAGE)/$(BUILD_VARIANT)-$(img); \
	)
endef

$(eval $(call BuildPackage/Optee-os))
