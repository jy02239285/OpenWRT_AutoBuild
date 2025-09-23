#!/bin/bash

# ============================================
# OpenWrt DIY 脚本 - 终极版本
# 第三部分 - 针对 AX3000T 定制
# ============================================

# OpenWrt 源码目标路径
DEST_DIR="files/etc/uci-defaults"

echo "=== 终极调试 ==="
echo "当前目录: $(pwd)"
echo "Part3_sh: $Part3_sh"

# 列出所有可能的相关文件
echo "搜索整个工作空间..."
find "$GITHUB_WORKSPACE" -type f \( -name "99-*" -o -name "*.sh" \) 2>/dev/null | sort

# 确保目标目录存在
mkdir -p "$DEST_DIR"

# 直接使用环境变量中的路径
MAIN_REPO_DIR="/home/runner/work/OpenWRT_AutoBuild/OpenWRT_AutoBuild/main-repo"
SRC_FILE="$MAIN_REPO_DIR/files/etc/uci-defaults/99-custom-network-wifi"

echo "尝试路径: $SRC_FILE"

if [ -f "$SRC_FILE" ]; then
    echo "✅ 找到文件！"
    cp -f "$SRC_FILE" "$DEST_DIR/"
    echo "✅ 复制完成"
else
    echo "❌ 文件不存在"
    
    # 创建测试文件验证脚本是否执行
    echo "创建测试文件验证脚本执行..."
    echo "这是一个测试文件，说明脚本已执行" > "$DEST_DIR/test-file.txt"
    echo "如果看到这个文件，说明脚本执行了但没找到目标文件"
fi

# 最终验证
if [ -f "$DEST_DIR/99-custom-network-wifi" ]; then
    echo "🎉 成功！文件已就位"
else
    echo "⚠️ 失败：未找到目标文件"
    echo "当前目标目录内容:"
    ls -la "$DEST_DIR/" 2>/dev/null || echo "目录为空或不存在"
fi
