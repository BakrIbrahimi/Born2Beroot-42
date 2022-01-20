#!/bin/bash

Ar=$(uname -a)
CPUp=$(nproc)
vCPU=$(getconf _NPROCESSORS_ONLN)
MU=$(free -m | awk 'NR == 2 {printf("%d/%dMB (%.2f%%)\n"), $3, $2, $3/$2*100}')
DU=$(df -h --total | tail -1 | awk {'printf("%s/%s (%s)", $3 * 1024, $2, $5)'})
CU=$(top -bn 1 | grep 'Cpu' | awk {'printf("%.1f%%", $2 + $4)'})
LB=$(who -b | awk {'printf("%s %s", $3, $4)'})
LVMN=$(lsblk | grep -c 'lvm')
LVMA=$(if [ $LVMN -eq 0 ]; then echo no; else echo yes; fi)
TCP=$(cat /proc/net/sockstat | grep 'TCP' | awk {'printf("%s ESTABLISHED", $3)'})
UL=$(users | wc -w)
IPV6=$(ip a | grep 'ether' | awk {'printf("%s", $2)'})
IPV4=$(hostname -I)
NM=$(journalctl _COMM=sudo | grep -c 'COMMAND')

wall "    #Architecture : $Ar
    #CPU physical : $CPUp
    #vCPU : $vCPU
    #Memory Usage : $MU
    #Disk Usage : $DU
    #CPU load : $CU
    #Last boot : $LB
    #LVM use : $LVMA
    #Connexions TCP : $TCP
    #User log : $UL
    #Network : IP $IPV4 ($IPV6)
    #Sudo : $NM cmd"