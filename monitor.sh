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
