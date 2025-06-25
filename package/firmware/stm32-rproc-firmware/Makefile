#
# Copyright (C) 2025 Bootlin
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=stm32-rproc-firmware
PKG_RELEASE:=1

PKG_MAINTAINER:=Thomas Richard <thomas.richard@bootlin.com>

include $(INCLUDE_DIR)/package.mk

define Package/stm32-rproc-firmware/Default
  SECTION:=firmware
  CATEGORY:=Firmware
  TITLE:=UCSI firmware for Cortex M33
  DEPENDS:=@TARGET_stm32 +rproc
endef

define Package/stm32-rproc-firmware-stm32mp2-ucsi-stm32mp257f-dk
  $(call Package/stm32-rproc-firmware/Default)
  TITLE+= (stm32mp257f-dk)
  DEPENDS+=@TARGET_stm32_stm32mp2
  CONFLICT:=stm32-rproc-firmware-stm32mp2-ucsi-stm32mp257f-ev1
endef

define Package/stm32-rproc-firmware-stm32mp2-ucsi-stm32mp257f-ev1
  $(call Package/stm32-rproc-firmware/Default)
  TITLE+= (stm32mp257f-ev1)
  DEPENDS+=@TARGET_stm32_stm32mp2
  CONFLICT:=stm32-rproc-firmware-stm32mp2-ucsi-stm32mp257f-dk
endef


define Build/Compile
endef

define Package/stm32-rproc-firmware-stm32mp2-ucsi-stm32mp257f-dk/install
	$(INSTALL_DIR) $(1)/lib/firmware/stm32/stm32mp2/stm32mp257f-dk
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/stm32mp2/stm32mp257f-dk/USBPD_DRP_UCSI_CM33_NonSecure.elf \
		$(1)/lib/firmware/stm32/stm32mp2/stm32mp257f-dk
	$(LN) \
		stm32mp257f-dk/USBPD_DRP_UCSI_CM33_NonSecure.elf \
		$(1)/lib/firmware/stm32/stm32mp2/USBPD_DRP_UCSI_CM33_NonSecure.elf
endef

define Package/stm32-rproc-firmware-stm32mp2-ucsi-stm32mp257f-ev1/install
	$(INSTALL_DIR) $(1)/lib/firmware/stm32/stm32mp2/stm32mp257f-ev1
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/stm32mp2/stm32mp257f-ev1/USBPD_DRP_UCSI_CM33_NonSecure.elf \
		$(1)/lib/firmware/stm32/stm32mp2/stm32mp257f-ev1
	$(LN) \
		stm32mp257f-ev1/USBPD_DRP_UCSI_CM33_NonSecure.elf \
		$(1)/lib/firmware/stm32/stm32mp2/USBPD_DRP_UCSI_CM33_NonSecure.elf
endef

$(eval $(call BuildPackage,stm32-rproc-firmware-stm32mp2-ucsi-stm32mp257f-dk))
$(eval $(call BuildPackage,stm32-rproc-firmware-stm32mp2-ucsi-stm32mp257f-ev1))
