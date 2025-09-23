#!/bin/bash

# ============================================
# OpenWrt DIY 脚本
# 第三部分 - 针对 AX3000T 定制
# ============================================

# 源文件路径 - 直接从工作空间根目录查找
SRC_FILE="../files/etc/uci-defaults/99-custom-network-wifi"

# OpenWrt 源码目标路径
DEST_DIR="files/etc/uci-defaults"

echo "🔍 查找源文件: $SRC_FILE"
echo "📁 当前工作目录: $(pwd)"
echo "📁 GitHub 工作空间: $GITHUB_WORKSPACE"

# 调试信息 - 查看实际目录结构
echo "=== 目录结构调试 ==="
echo "当前目录: $(pwd)"
echo "上级目录内容:"
ls -la ../
echo "搜索 files 目录:"
find .. -name "files" -type d 2>/dev/null || echo "未找到 files 目录"
echo "搜索 99-custom-network-wifi 文件:"
find .. -name "99-custom-network-wifi" -type f 2>/dev/null || echo "未找到文件"
echo "==================="

# 确保目标目录存在
mkdir -p "$DEST_DIR"

# 复制文件
if [ -f "$SRC_FILE" ]; then
    cp -f "$SRC_FILE" "$DEST_DIR/"
    echo "✅ 已复制 $SRC_FILE 到 $DEST_DIR/"
else
    echo "❌ 未找到 $SRC_FILE"
    echo "💡 尝试其他可能路径..."
    
    # 尝试几种可能的路径
    POSSIBLE_PATHS=(
        "../files/etc/uci-defaults/99-custom-network-wifi"
        "../../files/etc/uci-defaults/99-custom-network-wifi"
        "$GITHUB_WORKSPACE/files/etc/uci-defaults/99-custom-network-wifi"
    )
    
    for path in "${POSSIBLE_PATHS[@]}"; do
        if [ -f "$path" ]; then
            echo "✅ 在备用路径找到文件: $path"
            cp -f "$path" "$DEST_DIR/"
            echo "✅ 已复制到 $DEST_DIR/"
            break
        else
            echo "❌ 未找到: $path"
        fi
    done
    
    # 如果所有路径都失败
    if [ ! -f "$DEST_DIR/99-custom-network-wifi" ]; then
        echo "❌ 所有路径尝试都失败，请检查文件位置"
        exit 1
    fi
fi

# 验证文件是否存在于目标目录
if [ -f "$DEST_DIR/99-custom-network-wifi" ]; then
    echo "🎉 验证成功：99-custom-network-wifi 已放置在源码目录！"
    echo "📋 文件内容预览:"
    head -n 5 "$DEST_DIR/99-custom-network-wifi"
else
    echo "⚠️ 验证失败：目标目录未找到 99-custom-network-wifi"
    exit 1
fi
