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

echo
echo "Memory Information"
echo "--------------------------------------"

MEM_TOTAL=$(free -m | awk '/^Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/^Mem:/ {print $3}')
MEM_AVAILABLE=$(free -m | awk '/^Mem:/ {print $7}')

MEM_USAGE=$((100 * (MEM_TOTAL - MEM_AVAILABLE) / MEM_TOTAL))

echo "Total Memory:     ${MEM_TOTAL} MB"
echo "Used Memory:      ${MEM_USED} MB"
echo "Available Memory: ${MEM_AVAILABLE} MB"
echo "Memory Usage:     ${MEM_USAGE}%"
echo
echo "Disk Information"
echo "--------------------------------------"

DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
DISK_AVAILABLE=$(df -h / | awk 'NR==2 {print $4}')
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')

echo "Total Disk Space:      $DISK_TOTAL"
echo "Used Disk Space:       $DISK_USED"
echo "Available Disk Space:  $DISK_AVAILABLE"
echo "Disk Usage:            $DISK_USAGE"

