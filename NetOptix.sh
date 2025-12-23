#!/bin/bash

# Color Definitions
RED='\033[38;2;231;76;60m'      # Red
BLUE='\033[38;5;32m'            # Blue
GREEN='\033[38;5;82m'           # Green
YELLOW='\033[38;5;226m'         # Yellow
CYAN='\033[38;5;51m'            # Cyan
MAGENTA='\033[38;5;171m'        # Magenta
NC='\033[0m'                    # No Color

create_quick_command() {
    local quick_command_path="/usr/local/bin/netoptix"
    echo "正在创建快速命令'netoptix'..."
    sudo bash -c "cat > $quick_command_path" << 'EOF'
curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/refs/heads/main/NetOptix.sh -o /tmp/netoptix.sh
bash /tmp/netoptix.sh
rm /tmp/netoptix.sh
EOF
    sudo chmod +x $quick_command_path
    echo -e "${GREEN}快速命令'netoptix'创建成功。现在您可以在任何地方运行'netoptix'。${NC}"
}

# Functions for Submenus
network_optimization_menu() {
    while true; do
        clear
        echo -e "${GREEN}== 网络与服务器优化 ==${NC}"
        echo -e "1) 安装 Hybla"
        echo -e "2) 安装 BBR"
        echo -e "3) 删除优化 (BBR 和 Hybla)"
        echo -e "4) 创建 Swap"
        echo -e "5) 创建 ZRAM"
        echo -e "6) MTU 查找 + 自动设置"
        echo -e "7) MTU 查找"
        echo -e "0) 返回主菜单"
        read -p "请输入您的选择: " choice
        case $choice in
            1)
                echo "正在运行 Hybla 脚本..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/hybla.sh -o /tmp/hybla.sh
                bash /tmp/hybla.sh
                rm /tmp/hybla.sh
                ;;
            2)
                echo "正在运行 BBR 脚本..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/bbr.sh -o /tmp/bbr.sh
                bash /tmp/bbr.sh
                rm /tmp/bbr.sh
                ;;
            3)
                echo "正在运行卸载脚本..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/uninstall.sh -o /tmp/uninstall.sh
                bash /tmp/uninstall.sh
                rm /tmp/uninstall.sh
                ;;
            4)
                echo "正在运行 Swap 脚本..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/swap.sh -o /tmp/swap.sh
                bash /tmp/swap.sh
                rm /tmp/swap.sh
                ;;
            5)
                echo "正在运行 ZRAM 脚本..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/zram.sh -o /tmp/zram.sh
                bash /tmp/zram.sh
                rm /tmp/zram.sh
                ;;
            6)
                echo "正在运行 MTU 查找 + 自动设置脚本..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/mtu.sh -o /tmp/mtu.sh
                bash /tmp/mtu.sh
                rm /tmp/mtu.sh
                ;;
            7)
                echo "正在运行 MTU 查找脚本..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/mtunoset.sh -o /tmp/mtunoset.sh
                bash /tmp/mtunoset.sh
                rm /tmp/mtunoset.sh
                ;;
            0) return ;;
            *) echo "无效选择。" ; sleep 2 ;;
        esac
    done
}

server_management_menu() {
    while true; do
        clear
        echo -e "${BLUE}== 服务器与网络管理 ==${NC}"
        echo -e "1) 阻止和解除阻止服务器 Ping"
        echo -e "2) 阻止种子列表"
        echo -e "3) 更改服务器 DNS"
        echo -e "4) 更改 SSH 端口"
        echo -e "5) 阻止和解除阻止私有网络"
        echo -e "6) 阻止和解除阻止伊朗 ISP"
        echo -e "7) 在 Ubuntu 上安装 mikrotik"
        echo -e "8) 安装监控系统 (Cockpit)"
	echo -e "9) 安装自动/手动 SSL marzban"
        echo -e "0) 返回主菜单"
        read -p "请输入您的选择: " choice
        case $choice in
            1)
                echo "正在运行服务器 Ping 阻止器..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/Ping.sh -o /tmp/Ping.sh
                bash /tmp/Ping.sh
                rm /tmp/Ping.sh
                ;;
            2)
                echo "正在运行阻止种子列表..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/blocktorrent/blocktorrent.sh -o /tmp/blocktorrent.sh
                bash /tmp/blocktorrent.sh
                rm /tmp/blocktorrent.sh
                ;;
            3)
                echo "正在运行服务器 DNS 更改器..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/dns.sh -o /tmp/dns.sh
                bash /tmp/dns.sh
                rm /tmp/dns.sh
                ;;
            4)
                echo "正在运行 SSH 端口更改器..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/cport.sh -o /tmp/cport.sh
                bash /tmp/cport.sh
                rm /tmp/cport.sh
                ;;
            5)
                echo "正在运行私有网络阻止器..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/pib.sh -o /tmp/pib.sh
                bash /tmp/pib.sh
                rm /tmp/pib.sh
                ;;
            6)
                echo "正在运行伊朗 ISP 阻止器..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/isp-blocker/block-isp.sh -o /tmp/block-isp.sh
                bash /tmp/block-isp.sh
                rm /tmp/block-isp.sh
                ;;
            7)
                echo "正在运行 Mikrotik 安装程序..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/mikrotik.sh -o /tmp/mikrotik.sh
                bash /tmp/mikrotik.sh
                rm /tmp/mikrotik.sh
                ;;
            8)
                echo "正在安装监控系统..."
                sudo apt update
                sudo apt install cockpit
                sudo systemctl start cockpit
                echo "完成。通过 IP:9090 访问监控系统。(用户: root / 密码: 服务器密码)"
                sleep 10
                ;;
            9)
                echo "正在运行自动 SSL Marzban..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/sslmarzban.sh -o /tmp/sslmarzban.sh
                bash /tmp/sslmarzban.sh
                rm /tmp/sslmarzban.sh
                ;;
            0) return ;;
            *) echo "无效选择。" ; sleep 2 ;;
        esac
    done
}

security_menu() {
    while true; do
        clear
        echo -e "${RED}== 安全 ==${NC}"
        echo -e "1) 安装 Fail2ban 以增强 SSH 安全"
        echo -e "2) 阻止和解除阻止所有 SpeedTest 网站"
	echo -e "3) 安装 ClamAV (服务器防病毒软件)"
        echo -e "0) 返回主菜单"
        read -p "请输入您的选择: " choice
        case $choice in
            1)
                echo "正在安装 Fail2ban..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/fail2ban.sh -o /tmp/fail2ban.sh
                bash /tmp/fail2ban.sh
                rm /tmp/fail2ban.sh
                ;;
            2)
                echo "正在运行 SpeedTest 阻止器..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/speedtest/speedtest.sh -o /tmp/speedtest.sh
                bash /tmp/speedtest.sh
                rm /tmp/speedtest.sh
                ;;
            3)
	    echo "正在运行 ClamAV 安装程序..."
                curl -fsSL https://raw.githubusercontent.com/MrAminiDev/NetOptix/main/scripts/ClamAV.sh -o /tmp/ClamAV.sh
                bash /tmp/ClamAV.sh
                rm /tmp/ClamAV.sh
                ;;
            0) return ;;
            *) echo "无效选择。" ; sleep 2 ;;
        esac
    done
}

system_maintenance_menu() {
    while true; do
        clear
        echo -e "${MAGENTA}== 系统维护 ==${NC}"
        echo -e "1) 修复 WhatsApp 数据和时间"
        echo -e "2) 禁用 IPv6"
        echo -e "0) 返回主菜单"
        read -p "请输入您的选择: " choice
        case $choice in
            1)
                echo "正在修复 WhatsApp 数据和时间..."
                sudo timedatectl set-timezone Asia/Tehran
                echo "完成。WhatsApp 数据和时间已修复。"
                sleep 3
                ;;
            2)
                echo "正在禁用 IPv6..."
                sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
                sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
                sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1
                echo "完成。IPv6 已禁用。"
                sleep 3
                ;;
            0) return ;;
            *) echo "无效选择。" ; sleep 2 ;;
        esac
    done
}

# Main Menu
while true; do
    clear
    echo -e "${CYAN}+======================================================================+${NC}"
    echo -e "${RED}##    ## ######## ########  #######  ########  ######## #### ##     ## ${NC}"
    echo -e "${RED}###   ## ##          ##    ##     ## ##     ##    ##     ##   ##   ##  ${NC}"
    echo -e "${RED}####  ## ##          ##    ##     ## ##     ##    ##     ##    ## ##   ${NC}"
    echo -e "${RED}## ## ## ######      ##    ##     ## ########     ##     ##     ###    ${NC}"
    echo -e "${RED}##  #### ##          ##    ##     ## ##           ##     ##    ## ##   ${NC}"
    echo -e "${RED}##   ### ##          ##    ##     ## ##           ##     ##   ##   ##  ${NC}"
    echo -e "${RED}##    ## ########    ##     #######  ##           ##    #### ##     ## ${NC}"
    echo -e "${CYAN}+======================================================================+${NC}"
    echo -e "|  Telegram 频道 : ${MAGENTA}@AminiDev ${NC}|  版本 : ${GREEN} 4.3.1${NC} "
    echo -e "${CYAN}+======================================================================+${NC}"
    echo -e "${CYAN}== 主菜单 ==${NC}"
    echo -e "1) 网络与服务器优化"
    echo -e "2) 服务器与网络管理"
    echo -e "3) 安全"
    echo -e "4) 系统维护"
    echo -e "0) 退出"
    read -p "请输入您的选择: " main_choice
    case $main_choice in
        1) network_optimization_menu ;;
        2) server_management_menu ;;
        3) security_menu ;;
        4) system_maintenance_menu ;;
        0)
            create_quick_command
            echo "正在退出..."
            exit 0 ;;
        *) echo "无效选择。" ; sleep 2 ;;
    esac
done
