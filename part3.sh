#!/bin/bash

# =================================
# part3.sh - 自定义文件复制脚本
# 功能：将仓库中的 files 目录复制到 OpenWrt 源码根目录
# =================================

set -e # 遇到任何错误立即退出，便于调试

echo "🔄 [DIY Part 3] 开始执行自定义文件复制操作..."
echo "当前工作目录: $(pwd)"

# 定义源路径和目标路径
SOURCE_DIR="$GITHUB_WORKSPACE/main-repo/files" # 你仓库中的 files 目录
TARGET_DIR="$(pwd)" # OpenWrt 源码根目录

echo "📁 源目录: $SOURCE_DIR"
echo "🎯 目标目录: $TARGET_DIR"

# 检查源目录是否存在
if [ -d "$SOURCE_DIR" ]; then
    echo "✅ 找到源目录，开始复制 files 目录内容..."
    
    # 检查源目录是否为空
    if [ -z "$(ls -A "$SOURCE_DIR")" ]; then
        echo "⚠️  源目录为空，跳过复制。"
        exit 0
    fi
    
    # 复制 files 目录下的所有内容到 OpenWrt 源码根目录
    # -r: 递归复制
    # -v: 显示复制过程（详细模式）
    # -f: 强制覆盖已存在的文件
    cp -rfv "$SOURCE_DIR/"* "$TARGET_DIR"/
    
    echo "✅ 文件复制完成！"
    
    # 验证 network 文件是否复制成功
    NETWORK_FILE="$TARGET_DIR/etc/config/network"
    if [ -f "$NETWORK_FILE" ]; then
        echo "✅ 验证成功: network 文件已复制到目标位置"
        echo "📄 文件路径: $NETWORK_FILE"
        echo "🔍 network 文件内容预览（前5行）:"
        head -5 "$NETWORK_FILE"
    else
        echo "❌ 错误: network 文件未找到！请检查路径。"
        exit 1
    fi

    # 【新增】验证 wireless 文件是否复制成功
    WIRELESS_FILE="$TARGET_DIR/etc/config/wireless"
    if [ -f "$WIRELESS_FILE" ]; then
        echo "✅ 验证成功: wireless 文件已复制到目标位置"
        echo "📄 文件路径: $WIRELESS_FILE"
        echo "🔍 wireless 文件内容预览（前10行）:"
        head -10 "$WIRELESS_FILE"
        echo "..." 
        # 强烈建议检查是否设置了加密
        echo "🔒 检查无线加密设置:"
        if grep -q "option encryption 'none'" "$WIRELESS_FILE"; then
            echo "❌ 警告: 发现未加密的无线配置 (encryption 'none')！请务必设置密码！"
            # 你可以选择将此作为错误并退出 exit 1，或者仅作为警告
        elif grep -q "option encryption" "$WIRELESS_FILE"; then
            echo "✅ 良好: 无线配置中已设置加密方式。"
        else
            echo "⚠️  注意: 未在预览部分找到加密设置，请确保完整配置已包含加密选项。"
        fi
    else
        echo "⚠️  警告: wireless 文件未找到！如果不需要自定义无线配置可忽略。"
        # 如果你要求必须存在无线配置，可以将 echo 改为错误并 exit 1
    fi
    
else
    echo "❌ 错误: 源目录 $SOURCE_DIR 不存在！"
    echo "请检查仓库中 files 目录的路径是否正确。"
    exit 1
fi

echo "🎉 [ Part 3] 脚本执行完成！"
