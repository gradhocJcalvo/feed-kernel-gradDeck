# Using the package repositories

## Getting repositories

If you are using images from the Starter Package (pre-built images or generated
by the Image Builder) you can use the repositories provided in the
[Starter Package](../README.md#starter-package). Otherwise the repositories are
located in:

- `openwrt/bin/targets/stm32/stm32mp1/packages` and
  `openwrt/bin/packages/arm_cortex-a7_neon-vfpv4/st` for `stm32mp1`
- `openwrt/bin/targets/stm32/stm32mp2/packages` and
  `openwrt/bin/packages/aaarch64_generic/st` for `stm32mp2`.

## Install the repositories

```
$ mkdir -p repositories/stm32mp1
$ tar -C repositories/stm32mp1/ -xvf openwrt-stm32-stm32mp1-target-repository.tar.gz
$ mkdir -p repositories/arm_cortex-a7_neon-vfpv4/st
$ tar -C repositories/arm_cortex-a7_neon-vfpv4/st -xvf openwrt-stm32-stm32mp1-st-repository.tar.gz
```

## Start a http server

```
$ python -m http.server -d repositories/
Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
```

## Configure opkg

```
root@OpenWrt:~# cat /etc/opkg/distfeeds.conf
src/gz openwrt_base https://downloads.openwrt.org/releases/24.10.1/packages/arm_cortex-a7_neon-vfpv4/base
src/gz openwrt_luci https://downloads.openwrt.org/releases/24.10.1/packages/arm_cortex-a7_neon-vfpv4/luci
src/gz openwrt_packages https://downloads.openwrt.org/releases/24.10.1/packages/arm_cortex-a7_neon-vfpv4/packages
src/gz openwrt_routing https://downloads.openwrt.org/releases/24.10.1/packages/arm_cortex-a7_neon-vfpv4/routing
src/gz openwrt_telephony https://downloads.openwrt.org/releases/24.10.1/packages/arm_cortex-a7_neon-vfpv4/telephony
src/gz feed_stm32mp1 http://192.168.1.13:8000/stm32mp1
src/gz feed_st http://192.168.1.13:8000/arm_cortex-a7_neon-vfpv4/st

root@OpenWrt:~# opkg update
```

## Install a new package

```
root@OpenWrt:~# opkg install uqmi
```

