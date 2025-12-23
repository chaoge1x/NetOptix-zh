#!/bin/bash
#
# Auto change SSH port
#
# System Required:  CentOS 6+, Debian8+, Ubuntu16+
#
# Copyright (C) 2024 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/

read -p "请输入新的 SSH 端口: " new_port

if [[ $new_port -lt 1 || $new_port -gt 65535 ]]; then
    echo "无效端口号。请输入 1 到 65535 之间的数字。"
    exit 1
fi

cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

sed -i "s/^#Port 22/Port $new_port/" /etc/ssh/sshd_config
sed -i "s/^Port [0-9]*/Port $new_port/" /etc/ssh/sshd_config

systemctl restart ssh

echo "SSH 端口已成功更改为 $new_port。"
sleep 5
if command -v ufw > /dev/null 2>&1; then
    ufw allow $new_port/tcp
    ufw reload
    echo "新端口已添加到防火墙。"
elif command -v firewall-cmd > /dev/null 2>&1; then
    firewall-cmd --permanent --add-port=$new_port/tcp
    firewall-cmd --reload
    echo "新端口已添加到防火墙。"
else
    echo "防火墙不受支持或未安装。请手动添加新端口。"
fi
