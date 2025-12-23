#!/bin/bash
#
# Auto install Swap
#
# System Required:  CentOS 6+, Debian8+, Ubuntu16+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/

if [[ $EUID -ne 0 ]]; then
   echo "此脚本必须以 root 身份运行。请使用 sudo。" 
   exit 1
fi

read -p "请输入 swap 空间的大小（MB）: " swap_size

if ! [[ "$swap_size" =~ ^[0-9]+$ ]]; then
    echo "请输入有效的数字。"
    exit 1
fi

block_size=$((swap_size * 1024))

swap_file="/swapfile"

fallocate -l ${swap_size}M $swap_file

chmod 600 $swap_file

mkswap $swap_file

swapon $swap_file

echo "$swap_file none swap sw 0 0" | tee -a /etc/fstab

echo "大小为 ${swap_size}MB 的 Swap 空间已成功创建并启用。"

read -p "按 Enter 继续..."

xdg-open https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/NetOptix.sh

swapon --show