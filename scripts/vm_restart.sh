#!/bin/bash

VM="ubuntu@choy-linuxdev.imanagelabs.com"
NC="\033[0;0m"
BLUE="\033[0;34m"
GREEN="\033[1;32m"

if ping $VM; then
    echo -e "${BLUE}Restarting the vm...${NC}"
    ssh $VM "uptime && sudo shutdown -r now"
fi

echo -e "${BLUE}Waiting for vm to become available...${NC}"
SECONDS=0
until ssh $VM "uptime"; do
    echo $SECONDS seconds waiting.
    sleep 15s
done

echo -e "${GREEN}Restart success! VM is now available${NC}"
exit 0
