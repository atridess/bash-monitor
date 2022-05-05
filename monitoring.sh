#!/bin/bash

#@version 1.1.0

function get_processes(){
	ps -e -o pcpu,pid,user,args|sort -k1 -nr|head -10
}

function display_info(){
	echo "--- Kernel -------------------------------
Kernel: $kernel
Uptime: $uptime

--- Memory -------------------------------
$mem_total
$mem_free

--- CPU ----------------------------------
CPU $cpu_model
$cpu_usage

--- Disk ---------------------------------
$disk_available

--- Running Jobs -------------------------"
	get_processes
}

function update(){
	#clear
	printf '%s%s' "$ED" "$HOME"
	display_info
}


hostname=$(hostname)
kernel=$(uname -v)
tasks=$(ps -e --no-headers | wc -l)
uptime=$(uptime)
mem_total=$(cat /proc/meminfo | grep MemTotal)
mem_free=$(cat /proc/meminfo | grep MemFree)
cpu_model=$(cat /proc/cpuinfo | grep "model name")
cpu_usage=$(mpstat -P ALL)
disk_available=$(df -h | grep /dev/sd)


HOME=$(tput cup 0 0)
ED=$(tput ed)
EL=$(tput el)

clear
while [ true ]; do

	update
	sleep 1s
done
