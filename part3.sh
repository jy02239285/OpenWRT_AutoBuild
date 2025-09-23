#!/bin/bash

# ============================================
# OpenWrt DIY 脚本
# 第三部分 - 针对 AX3000T 定制
# ============================================

# 使用 GitHub Actions 提供的环境变量
SRC_FILE="$GITHUB_WORKSPACE/main-repo/files/etc/uci-defaults/99-custom-network-wifi"

# OpenWrt 源码目标路径
DEST_DIR="files/etc/uci-defaults"

echo "🔍 查找源文件: $SRC_FILE"
echo "📁 当前工作目录: $(pwd)"
echo "📁 GitHub 工作空间: $GITHUB_WORKSPACE"

# 确保目标目录存在
mkdir -p "$DEST_DIR"

# 复制文件
if [ -f "$SRC_FILE" ]; then
    cp -f "$SRC_FILE" "$DEST_DIR/"
    echo "✅ 已复制 $SRC_FILE 到 $DEST_DIR/"
else
    echo "❌ 未找到 $SRC_FILE，请检查路径是否正确！"
    echo "📂 检查目录结构:"
    find "$GITHUB_WORKSPACE" -name "99-custom-network-wifi" -type f 2>/dev/null || echo "未找到匹配文件"
    exit 1
fi

# 验证文件是否存在于目标目录
if [ -f "$DEST_DIR/99-custom-network-wifi" ]; then
    echo "🎉 验证成功：99-custom-network-wifi 已放置在源码目录，编译时会自动打包！"
    echo "📋 文件内容预览:"
    cat "$DEST_DIR/99-custom-network-wifi"
else
    echo "⚠️ 验证失败：目标目录未找到 99-custom-network-wifi，请检查！"
    exit 1
fi
