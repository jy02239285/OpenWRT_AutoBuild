#!/bin/bash
# ============================================
# OpenWrt DIY 脚本
# 第三部分 - 针对 AX3000T 定制
# ============================================
# 文件名: diy-part3.sh
# 描述: 自动复制自定义 network + wifi 配置到源码目录
#

# 源文件路径 (你自己准备的文件)
SRC_FILE="files/etc/uci-defaults/99-custom-network-wifi"

# OpenWrt 源码目标路径
DEST_DIR="openwrt/files/etc/uci-defaults"

# 确保目标目录存在
mkdir -p "$DEST_DIR"

# 复制文件
if [ -f "$SRC_FILE" ]; then
    cp -f "$SRC_FILE" "$DEST_DIR/"
    echo "✅ 已复制 $SRC_FILE 到 $DEST_DIR/"
else
    echo "❌ 未找到 $SRC_FILE，请检查路径是否正确！"
    exit 1
fi

# 验证文件是否存在于目标目录
if [ -f "$DEST_DIR/99-custom-network-wifi" ]; then
    echo "🎉 验证成功：99-custom-network-wifi 已放置在源码目录，编译时会自动打包！"
else
    echo "⚠️ 验证失败：目标目录未找到 99-custom-network-wifi，请检查！"
    exit 1
fi
