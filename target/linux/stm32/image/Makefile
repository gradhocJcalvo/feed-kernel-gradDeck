# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2024 Bootlin
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

define Build/boot-img-ext4
	rm -fR $@.boot
	mkdir -p $@.boot
	$(foreach dts,$(DEVICE_DTS), $(CP) $(KDIR)/image-$(dts).dtb $@.boot/$(dts).dtb;)
	$(CP) $(IMAGE_KERNEL) $@.boot/$(KERNEL_IMG)
	$(INSTALL_DIR) $@.boot/extlinux
	$(CP) ./extlinux.conf $@.boot/extlinux/
	$(SED) 's/@KERNEL@/$(KERNEL_IMG)/' $@.boot/extlinux/extlinux.conf
	$(SED) 's/@DEVICE@/$(DEVICE_NAME)/' $@.boot/extlinux/extlinux.conf
	$(SED) 's/@DTS@/$(DEVICE_DTS)/' $@.boot/extlinux/extlinux.conf
	$(SED) 's/@ROOT@/PARTUUID=$(shell echo $(IMG_PART_DISKGUID) | sed 's/00$$/05/')/' $@.boot/extlinux/extlinux.conf
	$(SED) 's/@BOOTARGS@/$(BOOTARGS)/' $@.boot/extlinux/extlinux.conf

	make_ext4fs -J -L kernel -l $(CONFIG_TARGET_KERNEL_PARTSIZE)M \
		$(if $(SOURCE_DATE_EPOCH),-T $(SOURCE_DATE_EPOCH)) \
		$@.bootimg $@.boot
endef

define Device/Default
  PROFILES := Default
  DEVICE_VENDOR := GradDeck
  
  KERNEL := kernel-bin
  DEVICE_DTS_DIR:= $(DTS_DIR)/st
  ENV_SIZE := 0x200000
  DEVICE_PACKAGES := kmod-usb2 \
		     kmod-usb-storage \
		     kmod-usb-ledtrig-usbport \
		     -mtd
  BOOTARGS := fw_devlink=on
endef

define Device/stm32mp2
  KERNEL_NAME := Image.gz
  KERNEL_IMG := Image.gz
  BOOTARGS += console=ttySTM0,115200n8 fw_devlink.sync_state=timeout
  DEVICE_PACKAGES += kmod-usb-stm32-usbh
endef

define Device/stm32mp257f-ev1
  $(call Device/stm32mp2)
  DEVICE_MODEL := STM32MP257F-EV1
  DEVICE_DTS := stm32mp257f-ev1
  SUPPORTED_DEVICES := st,stm32mp257f-ev1
endef

ifeq ($(SUBTARGET),stm32mp2)
  TARGET_DEVICES += stm32mp257f-ev1
endif

define Build/emmc-img
	mkdir -p $@
	$(CP) $(IMAGE_KERNEL) $@/$(KERNEL_IMG)
	$(CP) $(foreach dts,$(DEVICE_DTS),$(KDIR)/image-$(dts).dtb) $@/
endef

include demo.mk

$(eval $(call BuildImage))
