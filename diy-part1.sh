#!/bin/bash
echo "执行自定义脚本第一部分 - 设置系统参数"

# 设置root密码为空
sed -i 's|root:.*|root::0:0:99999:7:::|g' package/base-files/files/etc/shadow || true

echo "系统参数设置完成"
