#!/bin/bash
# sysinfo.sh — Display basic system information

# Colors for formatting
GREEN="\e[32m"
CYAN="\e[36m"
RESET="\e[0m"

echo -e "${GREEN}=============================="
echo -e "  System Information Summary"
echo -e "==============================${RESET}"

# Hostname and OS
echo -e "${CYAN}Hostname:${RESET} $(hostname)"
echo -e "${CYAN}OS:${RESET} $(lsb_release -d | cut -f2)"
echo -e "${CYAN}Kernel:${RESET} $(uname -r)"
echo -e "${CYAN}Uptime:${RESET} $(uptime -p)"
echo -e "${CYAN}Shell:${RESET} $SHELL"

# Hardware info
echo -e "\n${GREEN}--- Hardware ---${RESET}"
echo -e "${CYAN}CPU:${RESET} $(lscpu | grep 'Model name' | sed 's/Model name:\s*//')"
echo -e "${CYAN}Cores:${RESET} $(nproc)"
echo -e "${CYAN}Memory:${RESET} $(free -h | awk '/Mem:/ {print $3 "/" $2}')"
echo -e "${CYAN}GPU:${RESET} $(lspci | grep -E "VGA|3D" | cut -d: -f3)"

# Storage
echo -e "\n${GREEN}--- Storage ---${RESET}"
df -h --total | grep 'total'

# Packages
echo -e "\n${GREEN}--- Software ---${RESET}"
PKG_COUNT=$(dpkg -l | grep '^ii' | wc -l)
echo -e "${CYAN}Installed packages:${RESET} $PKG_COUNT"

# Network
echo -e "\n${GREEN}--- Network ---${RESET}"
echo -e "${CYAN}IP Address:${RESET} $(hostname -I | awk '{print $1}')"
echo -e "${CYAN}Default Gateway:${RESET} $(ip route | grep default | awk '{print $3}')"

# Disk usage of home directory
echo -e "\n${GREEN}--- Disk Usage ---${RESET}"
du -sh ~ 2>/dev/null | awk '{print "Home directory size:", $1}'

echo -e "\n${GREEN}=============================="
echo -e "      End of Report"
echo -e "==============================${RESET}"

