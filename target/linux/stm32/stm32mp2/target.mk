# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2024 Bootlin
#

BOARDNAME:=STM32MP2 boards
ARCH:=aarch64
FEATURES+=fpu usbgadget
KERNEL_IMAGES:=Image.gz

DEFAULT_PACKAGES += blockdev kmod-gpio-button-hotplug
