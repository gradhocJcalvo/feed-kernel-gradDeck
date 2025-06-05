# Using the OpenWrt Image Builder

## Compiling the OpenWrt Image Builder

It is possible to compile the OpenWRT Image Builder, using the following
configuration
```
CONFIG_ALL_KMODS=y
CONFIG_ALL_NONSHARED=y
CONFIG_IB=y
CONFIG_IB_STANDALONE=y
```

It is highly recommended to build all components, including images, SDK, and
Image Builder, using the same OpenWrt configuration.

The precompiled Image Builder is stored in the bin directory
`bin/targets/stm32/<subtarget>`.

```bash
$ ls bin/targets/stm32/stm32mp1/openwrt-imagebuilder-stm32-stm32mp1.Linux-x86_64.tar.zst
bin/targets/stm32/stm32mp1/openwrt-imagebuilder-stm32-stm32mp1.Linux-x86_64.tar.zst
```

## Using the OpenWrt Image Buider

### Extract the Image Builder archive

```bash
$ tar xvf openwrt-imagebuilder-stm32-stm32mp1.Linux-x86_64.tar.zst
```

### Configure the repositories

The Image Builder only embeds target specific packages. OpenWrt repositories
shall be added to have access to all packages. And they shall be defined before
the imagebuilder repository.
For `stm32mp1` subtarget use the following repositories:

```bash
$ cat repositories.conf
src/gz core https://downloads.openwrt.org/releases/24.10.1/packages/arm_cortex-a7_neon-vfpv4/base
src/gz packages https://downloads.openwrt.org/releases/24.10.1/packages/arm_cortex-a7_neon-vfpv4/packages
src/gz luci https://downloads.openwrt.org/releases/24.10.1/packages/arm_cortex-a7_neon-vfpv4/luci
src/gz routing https://downloads.openwrt.org/releases/24.10.1/packages/arm_cortex-a7_neon-vfpv4/routing
src/gz telephony https://downloads.openwrt.org/releases/24.10.1/packages/arm_cortex-a7_neon-vfpv4/telephony

## This is the local package repository, do not remove!
src imagebuilder file:packages

option check_signature
```

For `stm32mp2` subtarget use the following repositories:

```bash
$ cat repositories.conf
src/gz core https://downloads.openwrt.org/releases/24.10.1/packages/aarch64_generic/base
src/gz packages https://downloads.openwrt.org/releases/24.10.1/packages/aarch64_generic/packages
src/gz luci https://downloads.openwrt.org/releases/24.10.1/packages/aarch64_generic/luci
src/gz routing https://downloads.openwrt.org/releases/24.10.1/packages/aarch64_generic/routing
src/gz telephony https://downloads.openwrt.org/releases/24.10.1/packages/aarch64_generic/telephony

## This is the local package repository, do not remove!
src imagebuilder file:packages

option check_signature
```

### Building Image

Detailed help is available using the `make help` command and in the [OpenWRT
Image Builder Wiki
page](https://openwrt.org/docs/guide-user/additional-software/imagebuilder).

Below the make command to build an image based on `stm32mp135f-dk-demo` profile
with openvpn package installed and dropbear service disabled.

```bash
$ make image PROFILE="stm32mp135f-dk-demo" PACKAGES="openvpn" DISABLED_SERVICES="dropbear"
```
