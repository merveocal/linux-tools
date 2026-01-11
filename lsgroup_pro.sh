#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "Please run with: sudo ./lsgroup_pro.sh"
   exit 1
fi

clear
printf "%-15s | %-6s |%-20s\n" "GROUP NAME" "GID" "CREATION DATE"

awk -F: '$3 >= 1000 && $3 < 65534 {print $1 ":" $3}' /etc/group | while read -r line;do
	GROUP_NAME=$(echo "$line" | cut -d: -f1)
	GROUP_ID=$(echo "$line" | cut -d: -f2)

	LOG_DATE=$(journalctl | grep "new group: name=$GROUP_NAME" | head -n 1 | awk '{print $1, $2, $3}')

	if [ -z "$LOG_DATE" ]; then
		LOG_DATE=$(grep -sh "new group: name=$GROUP_NAME" /var/log/auth.log /var/log/syslog* 2>/dev/null | head -n 1 | awk '{print $1, $2, $3}')
	fi
	if [ -z "$LOG_DATE" ]; then
		LOG_DATE="Created Today"
	fi

	printf "%-15s | %-6s | %-20s\n" "$GROUP_NAME" "$GROUP_ID" "$LOG_DATE"
done
