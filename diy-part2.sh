#!/bin/bash
# https://github.com/
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/OpenWrt.Lan/g' package/base-files/files/bin/config_generate

# Modify default IP 10.0.0.1/24
#sed -i "/ipaddr/s/.*/\t\tset network.lan.ipaddr='10.0.0.1'/" package/base-files/files/bin/config_generate
#sed -i "/netmask/s/.*/\t\tset network.lan.netmask='255.255.255.0'/" package/base-files/files/bin/config_generate
