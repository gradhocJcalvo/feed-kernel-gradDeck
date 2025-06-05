# Using the OpenWrt SDK

## Compiling the SDK

It is possible to compile the OpenWRT SDK by simply enabling the menuconfig
option `Build the OpenWrt SDK` (CONFIG_SDK). For BPF support the options
`CONFIG_DEVEL` and `CONFIG_SDK_LLVM_BPF` shall be selected.

```
CONFIG_ALL_KMODS=y
CONFIG_DEVEL=y
CONFIG_SDK=y
CONFIG_SDK_LLVM_BPF=y
```

The `CONFIG_ALL_KMODS` option is not mandatory, but it does affect your kernel
configuration. The kernel configuration in the SDK should match the one in your
device if you plan to use a package repository, or it should match the one in
your Image Builder if you plan to build a package and use it in the Image
Builder. Otherwise, some dependency issues may arise.

It is highly recommended to build all components, including images, SDK, and
Image Builder, using the same OpenWrt configuration.

The precompiled SDK is stored in the bin directory
`bin/targets/stm32/<subtarget>`.

```bash
$ ls bin/targets/stm32/stm32mp1/openwrt-sdk-stm32-stm32mp1_gcc-13.3.0_musl_eabi.Linux-x86_64.tar.zst
bin/targets/stm32/stm32mp1/openwrt-sdk-stm32-stm32mp1_gcc-13.3.0_musl_eabi.Linux-x86_64.tar.zst
```

## Using the SDK

### SDK Setup

1. Extract the SDK

```bash
$ tar -xf openwrt-sdk-stm32-stm32mp1_gcc-13.3.0_musl_eabi.Linux-x86_64.tar.zst
$ cd openwrt-sdk-stm32-stm32mp1_gcc-13.3.0_musl_eabi.Linux-x86_64
```

2. Update the feeds

```bash
$ ./scripts/feeds update -a
```

3. Install stm32 target

```bash
$ ./scripts/feeds install -f -p st stm32
```

4. Install packages from st feed

```bash
$ ./scripts/feeds install -a -p st
```

5. Install all packages

```bash
$ ./scripts/feeds install -a
```

6. Enter in menuconfig

```bash
$ make menuconfig
```

7. Enter `Global Build Settings` and in the submenu, deselect/exclude the following options:
- Select all target specific packages by default
- Select all kernel module packages by default
- Select all userspace packages by default

8. Save the configuration and exit the menu

### Build an existing package

To build an existing package, enter in menuconfig, find the package you want
to build and select it by pressing "m" (dependencies are automatically selected).
Then save the configuration and exit.

```bash
$ make package/tcpdump/compile
```

### Add and build a new package

```
$ mkdir package/phytool
$ cat << 'EOF' > ./package/phytool/Makefile
#
# Copyright (C) 2025 Bootlin
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=phytool
PKG_VERSION:=2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/wkz/phytool/releases/download/v$(PKG_VERSION)/
PKG_HASH:=9901a14e8c6af02b7333c60b21ff81f50620e8326d54827185e5617ff9b11d21

PKG_MAINTAINER:=Thomas Richard <thomas.richard@bootlin.com>

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENCE

include $(INCLUDE_DIR)/package.mk

define Package/phytool
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Linux MDIO register access
  URL:=https://github.com/wkz/phytool.git
endef

define Package/phytool/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/phytool $(1)/usr/bin/
endef

$(eval $(call BuildPackage,phytool))
EOF
```

Then run menuconfig and select phytool package

```bash
$ make package/phytool/compile
```

### Build a repository index

A repository index can be built using the following command

```bash
$ make package/index
```

By default index is signed, so a signing key is needed. For testing purpose you
can easily generate a signing key using the following command.

```bash
$ ./staging_dir/host/bin/usign -G -s ./key-build -p ./key-build.pub -c "Local build key"
```

Otherwise signature can be disabled in menuconfig (in `Global Build settings`
disable `Cryptographically sign package lists`).
