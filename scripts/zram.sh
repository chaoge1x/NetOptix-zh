#!/bin/bash
#
# Auto install Swap
#
# System Required:  CentOS 6+, Debian8+, Ubuntu16+
#
# Copyright (C) 2025 Mr.Amini Nezhad
#
# my Github: https://github.com/MrAminiDev/

install_prerequisites() {
    echo "正在检查先决条件..."
    if ! command -v modprobe &> /dev/null; then
        echo "正在为 modprobe 安装 kmod 包..."
        sudo apt update && sudo apt install -y kmod
    fi
    if ! ls /lib/modules/$(uname -r)/kernel/drivers/block | grep -q zram; then
        echo "正在安装 ZRAM 内核模块..."
        sudo apt update && sudo apt install -y linux-modules-extra-$(uname -r)
    fi
    echo "先决条件已安装。"
}

define_zram() {
    read -p "请输入 ZRAM 的大小（MB）: " zram_size
    if [[ $zram_size =~ ^[0-9]+$ ]]; then
        if ! sudo modprobe zram; then
            echo "错误：无法加载 ZRAM 模块。请检查您的内核版本。"
            return
        fi

        if [[ ! -e /sys/block/zram0 ]]; then
            echo "错误：未找到 ZRAM 设备。"
            return
        fi

        echo "正在创建大小为 ${zram_size}MB 的 ZRAM..."
        sudo bash -c "echo $(($zram_size * 1024 * 1024)) > /sys/block/zram0/disksize"
        sudo mkswap /dev/zram0
        sudo swapon /dev/zram0
        echo "$zram_size" | sudo tee /etc/zram_config > /dev/null
        echo "ZRAM 已创建并激活。配置已保存。"

        # Ensure persistence across reboots using systemd service
        create_zram_service $zram_size
    else
        echo "输入的大小无效。请输入以 MB 为单位的数值。"
    fi
}

create_zram_service() {
    local zram_size=$1
    sudo bash -c "cat <<EOL > /etc/systemd/system/zram.service
[Unit]
Description=ZRAM Configuration
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/bin/bash -c 'modprobe zram && echo \$(( ${zram_size} * 1024 * 1024 )) > /sys/block/zram0/disksize && mkswap /dev/zram0 && swapon /dev/zram0'
RemainAfterExit=true

[Install]
WantedBy=multi-user.target
EOL"
    sudo systemctl daemon-reload
    sudo systemctl enable zram.service
    echo "ZRAM 的 Systemd 服务已创建并启用。"
}

restore_zram() {
    if [[ -f /etc/zram_config ]]; then
        if ! sudo modprobe zram; then
            echo "错误：无法加载 ZRAM 模块。"
            return
        fi

        zram_size=$(cat /etc/zram_config)
        if [[ ! -e /sys/block/zram0 ]]; then
            echo "错误：未找到 ZRAM 设备。"
            return
        fi

        echo "正在恢复大小为 ${zram_size}MB 的 ZRAM..."
        sudo bash -c "echo $(($zram_size * 1024 * 1024)) > /sys/block/zram0/disksize"
        sudo mkswap /dev/zram0
        sudo swapon /dev/zram0
        echo "ZRAM 已恢复并激活。"
    fi
}

delete_zram() {
    echo "正在移除 ZRAM..."
    if [[ -e /dev/zram0 ]]; then
        sudo swapoff /dev/zram0
        sudo modprobe -r zram
    fi
    sudo rm -f /etc/zram_config
    if [[ -f /etc/systemd/system/zram.service ]]; then
        sudo systemctl disable zram.service
        sudo rm -f /etc/systemd/system/zram.service
        sudo systemctl daemon-reload
    fi
    echo "ZRAM 已移除，配置已删除。"
}

display_zram_info() {
    clear
    if [[ -e /sys/block/zram0 ]]; then
        disksize=$(cat /sys/block/zram0/disksize)
        mem_used=$(cat /sys/block/zram0/mem_used_total)
        echo "ZRAM 信息:"
        echo "- 磁盘大小: $((disksize / 1024 / 1024)) MB"
        echo "- 已用内存: $((mem_used / 1024 / 1024)) MB"
    else
        echo "未找到活动的 ZRAM 设备。"
    fi
    echo ""
    read -p "按 0 返回菜单: " return_choice
    if [[ $return_choice == "0" ]]; then
        clear
        return
    fi
}

install_prerequisites

restore_zram

while true; do
    echo "选择一个选项:"
    echo "1 - 创建 ZRAM"
    echo "2 - 删除 ZRAM"
    echo "3 - 显示 ZRAM 信息"
    echo "0 - 退出"
    read -p "请输入您的选择: " choice

    case $choice in
        1)
            define_zram
            ;;
        2)
            delete_zram
            ;;
        3)
            display_zram_info
            ;;
        0)
            echo "正在退出..."
            exit 0
            ;;
        *)
            echo "无效选项。请选择..."
            ;;
    esac

done
