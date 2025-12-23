#!/bin/bash
#
# Auto Disable ping server
#
# System Required: Debian8+, Ubuntu16+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/


disable_ping() {
    sudo iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
    sudo netfilter-persistent save
    echo "Ping 请求已被阻止并保存设置。"
}

enable_ping() {
    sudo iptables -D INPUT -p icmp --icmp-type echo-request -j DROP
    sudo netfilter-persistent save
    echo "Ping 请求已解除阻止并保存设置。"
}

while true; do
    clear
    echo "请选择一个选项:"
    echo "1) 禁用服务器 Ping"
    echo "2) 启用服务器 Ping"
    echo "3) 退出"
    echo
    read -p "请输入您的选择 [1-3]: " choice

    case $choice in
        1)
            disable_ping
            ;;
        2)
            enable_ping
            ;;
        3)
            echo "正在退出脚本。"
            exit 0
            ;;
        *)
            echo "无效选项！请输入 1 到 3 之间的数字。"
            ;;
    esac

    read -p "按任意键继续..." -n1 -s
done
