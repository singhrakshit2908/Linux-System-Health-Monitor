#!/bin/bash

# Linux System Health Monitor
# LSHM

echo "======================================"
echo "       Linux System Health Monitor"
echo "======================================"

echo
echo "System Information"
echo "--------------------------------------"

echo "Hostname: $(hostname)"
echo "Uptime:   $(uptime -p)"
echo "CPU Cores: $(nproc)"
echo
echo "CPU Information"
echo "--------------------------------------"

echo "CPU Cores: $(nproc)"

LOAD=$(uptime | awk -F'load average:' '{print $2}')
echo "Load Average:$LOAD"

read -r cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat

TOTAL1=$((user + nice + system + idle + iowait + irq + softirq + steal))
IDLE1=$((idle + iowait))

sleep 1

read -r cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat

TOTAL2=$((user + nice + system + idle + iowait + irq + softirq + steal))
IDLE2=$((idle + iowait))

TOTAL_DIFF=$((TOTAL2 - TOTAL1))
IDLE_DIFF=$((IDLE2 - IDLE1))

CPU_USAGE=$((100 * (TOTAL_DIFF - IDLE_DIFF) / TOTAL_DIFF))

echo "CPU Usage: ${CPU_USAGE}%"
