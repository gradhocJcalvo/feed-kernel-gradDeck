# Using the USB Type-C

Only demo profiles of `stmp32mp2` subtarget have USB Type-C support.
The controller is configured in dual-role mode. The mode (gadget or host) is
automatically detected.

The detection is done by the Cortex M33 processor which emulates a
stm32mp25-typec usb role switch to detect if the USB-C CN15 is plugged as a
device or a host.

## Configuration

To configure the Cortex M33 processor to act as a usb role switch, the
USBPD_DRP_UCSI firmware shall be loaded.

1. Create a uci-defaults script

```bash
root@OpenWrt:~# cat /etc/uci-defaults/90-usb-typec-rproc-config
#!/bin/sh

[ "$(uci -q get remoteproc.m33.name)" = "m33" ] && return 0

uci batch << EOI
set remoteproc.m33=rproc
set remoteproc.m33.name='m33'
set remoteproc.m33.firmware='stm32/stm32mp2/USBPD_DRP_UCSI_CM33_NonSecure.elf'
set remoteproc.m33.disabled='0'
commit
EOI
```

2. Reboot the board.

## Host mode

When a USB device is plugged, the controller automatically acts a host.

## Gadget mode

To create USB gadgets the usbgadget package shall be used. It allows to define
gadgets through UCI.

The demo profiles contain all needed packages to use USB OTG as a USB Ethernet
Gadget, and reproduce the demo provided in OpenSTLinux images
([script stm32_usbotg_eth_config.sh](https://github.com/STMicroelectronics/meta-st-openstlinux/blob/scarthgap/recipes-bsp/tools/usbotg-gadget-config/stm32_usbotg_eth_config.sh)).

Create the following uci-defaults script, then reboot the board.

```bash
root@OpenWrt:~# cat /etc/uci-defaults/90-usb-typec-usbgadget-ethernet-config
#!/bin/sh

. /lib/functions/system.sh

[ "$(uci -q get usbgadget.g1)" = "gadget" ] && return 0

subtarget="$(ubus call system board | jsonfilter -e "@.release.target" | sed -e 's#.*/##')"
serial="$(cat /proc/device-tree/serial-number)"
mac_hash="$(sha256sum /proc/device-tree/serial-number)"
mac_base="$(macaddr_canonicalize "$(echo "${mac_hash}" | dd bs=1 count=12 2>/dev/null)")"
mac="$(macaddr_unsetbit_mc "$(macaddr_setbit_la "${mac_base}")")"
udc="$(ls -1 /sys/class/udc/)"

uci batch << EOI
set usbgadget.g1=gadget
set usbgadget.g1.idVendor='0x1d6b'
set usbgadget.g1.idProduct='0x0104'
set usbgadget.g1.bcdUSB='0x200'
set usbgadget.g1.bDeviceClass='0xEF'
set usbgadget.g1.bDeviceSubClass='0x02'
set usbgadget.g1.bDeviceProtocol='0x01'
set usbgadget.g1.bcdDevice='0x100'
set usbgadget.g1.manufacturer='STMicroelectronics'
set usbgadget.g1.product="$subtarget"
set usbgadget.g1.serialnumber="$serial"
set usbgadget.g1.use='1'
set usbgadget.g1.b_vendor_code='0xBC'
set usbgadget.g1.qw_sign='MSFT100'
set usbgadget.g1.UDC="$udc"

set usbgadget.cfg1=configuration
set usbgadget.cfg1.configuration='Config 1: NCM'
set usbgadget.cfg1.MaxPower='0'
set usbgadget.cfg1.bmAttributes='0xC0'
set usbgadget.cfg1.gadget='g1'

set usbgadget.eth1=function
set usbgadget.eth1.function='ncm'
set usbgadget.eth1.configuration='cfg1'
set usbgadget.eth1.host_addr="$mac"
set usbgadget.eth1.compatible_id='WINNCM'

commit
EOI
```

Once the system is booted, a new network interface `usb0` is visible

```bash
root@OpenWrt:~# ifconfig usb0
usb0      Link encap:Ethernet  HWaddr 5A:DF:86:97:43:E2
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
```
