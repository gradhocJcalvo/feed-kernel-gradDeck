# Using the remote processors

This chapter is only valid for `stm32mp2` subtarget.
The `stm32mp2` subtarget has remote processor support (only enabled in demo
profiles). Both Cortex M33 and M0 are supported.

```bash
root@OpenWrt:~# cat /sys/class/remoteproc/*/name
m0
m33
```

## Rproc service

The rproc service is responsible to start the remote processors. It is
configurable through UCI.

The `remoteproc` configuration contains `rproc` sections which define the remote
processor configurations.

|Name|Type|Required|Default|Description|
|----|----|--------|-------|-----------|
|name|string|no|(none)|Remote processor name (`cat /sys/class/remoteproc/remoteprocX/name`)|
|firmware|string|yes|(none)|Path to the firmware to load (without `/lib/firmware` prefix)|
|disabled|bool|no|0|Set to 1 to disable starting the remote processor at system boot|

## Firmware example

The USBPD_DRP_UCSI firmware example for Cortex M33 is provided in demo images
for `stm32mp2` subtarget. It emulates a stm32mp25-typec usb role switch to
detect if the USB-C CN15 is plugged as a device or a host.

```bash
uci set remoteproc.m33=rproc
uci set remoteproc.m33.name='m33'
uci set remoteproc.m33.firmware='stm32/stm32mp2/USBPD_DRP_UCSI_CM33_NonSecure.elf'
uci set remoteproc.m33.disabled='0'
uci commit

/etc/init.d/rproc start
```

Check the Cortex M33 is running

```bash
root@OpenWrt:~# cat /sys/class/remoteproc/remoteproc1/name
m33
root@OpenWrt:~# cat /sys/class/remoteproc/remoteproc1/state
running
```
