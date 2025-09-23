#!/bin/bash
# ============================================
# OpenWrt DIY 脚本
# 第二部分 - 修改默认设置
# ============================================
# https://github.com/
# 文件名: diy-part2.sh
# 描述: OpenWrt DIY 脚本第 2 部分 (更新 feeds 之后执行)
#

# 修改默认 IP
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# 修改主机名
sed -i 's/hostname='OpenWrt'/hostname='AX3000T'/g' package/base-files/files/bin/config_generate

# 修改默认主题 (可选)
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
