#!/bin/bash
set -euo pipefail

print_header() {
    echo "=============================="
    echo "$1"
    echo "=============================="
}

print_hostname_os() {
    print_header "HOSTNAME & OS INFO"
    hostname
    uname -a
}

print_uptime() {
    print_header "UPTIME"
    uptime
}

print_disk_usage() {
    print_header "TOP 5 DISK USAGE"
    du -ah / 2>/dev/null | sort -rh | head -5
}

print_memory() {
    print_header "MEMORY USAGE"
    free -h
}

print_top_cpu() {
    print_header "TOP 5 CPU PROCESSES"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -6
}

main() {
    print_hostname_os
    print_uptime
    print_disk_usage
    print_memory
    print_top_cpu
}

main
