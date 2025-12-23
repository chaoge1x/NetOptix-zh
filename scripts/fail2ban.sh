#!/bin/bash
#
# Install and configure fail2ban automatically to increase ssh security
#
# System Required: Debian8+, Ubuntu16+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/

install_and_configure_fail2ban() {
    if ! command -v fail2ban-server &> /dev/null; then
        echo "未找到 fail2ban，正在安装..."
        sudo apt update && sudo apt install -y fail2ban
    else
        echo "fail2ban 已经安装。"
    fi

    sudo bash -c 'cat > /etc/fail2ban/jail.local' <<EOL
[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 5
bantime = 86400
EOL

    sudo systemctl restart fail2ban
    sudo systemctl enable fail2ban
    clear
    echo "fail2ban 已成功激活"
    sleep 5
}

disable_fail2ban() {
    sudo systemctl stop fail2ban
    sudo systemctl disable fail2ban
    clear
    echo "fail2ban 已成功禁用"
    sleep 5
}

clear_ban_list() {
    sudo fail2ban-client unban --all
    clear
    echo "阻止列表已成功清空"
    sleep 5
}

while true; do
    clear
    echo "请选择一个选项:"
    echo "1 - 启用 fail2ban"
    echo "2 - 禁用 fail2ban"
    echo "3 - 清空阻止列表"
    echo "4 - 退出"
    read -rp "请输入您的选择: " choice

    case $choice in
        1)
            install_and_configure_fail2ban
            break
            ;;
        2)
            disable_fail2ban
            break
            ;;
        3)
            clear_ban_list
            break
            ;;
        4)
            exit 0
            ;;
        *)
            echo "无效选项，请重试。"
            sleep 1
            ;;
    esac
done
