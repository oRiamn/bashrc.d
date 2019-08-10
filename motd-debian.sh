#!/bin/bash
 
INTERFACE=$(nmcli | head -n 1 | xargs | cut -d " " -f 1 | tr -d ":")
PROCCOUNT=`ps -Afl | wc -l`
PROCCOUNT=`expr $PROCCOUNT - 5`
GROUPZ=`groups`
USER=`whoami`
ADMINS=`cat /etc/group | grep --regex "^sudo" | awk -F: '{print $4}' | tr ',' '|'`
ADMINSLIST=`grep -E $ADMINS /etc/passwd | tr ':' ' ' | tr ',' ' ' | awk {'print $5,$6,"("$1")"'} | tr '\n' ',' | sed '$s/.$//'`
 
if [[ $GROUPZ == "$USER sudo" ]]; then
USERGROUP="Administrator"
elif [[ $USER = "root" ]]; then
USERGROUP="Root"
elif [[ $USER = "$USER" ]]; then
USERGROUP="Regular User"
else
USERGROUP="$GROUPZ"
fi
echo -e "
\033[1;31m                                      ╔═════════════════════════[\033[1;37mSystem Data\033[1;31m]═════════════════════════════════════
\033[1;31m                                      ║\033[1;37m       Hostname\033[1;31m: \033[1;37m`hostname`
\033[1;31m          _,met\$\$\$\$\$gg.               ║\033[1;37m   IPv4 Address\033[1;31m: \033[1;37m`ip addr show $INTERFACE | grep "inet\ " | awk {'print $2'}`
\033[1;31m       ,g\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$P.            ║\033[1;37m   IPv6 Address\033[1;31m: \033[1;37m`ip addr show $INTERFACE | grep -m 1 "inet6\ " | awk {'print $2'}`
\033[1;31m     ,g\$\$P\"\"       \"\"\"Y\$\$.\".          ║\033[1;37m         Kernel\033[1;31m: \033[1;37m`uname -r`
\033[1;31m    ,\$\$P'              \`\$\$\$.          ║\033[1;37m         Distro\033[1;31m: \033[1;37m`cat /etc/*release | grep \"PRETTY_NAME\" | cut -d "=" -f 2- | sed 's/\"//g'`
\033[1;31m  ',\$\$P       ,ggs.     \`\$\$b:         ║\033[1;37m         Uptime\033[1;31m: \033[1;37m`uptime | sed 's/.*up ([^,]*), .*/1/'`
\033[1;31m  \`d\$\$'     ,\$P\"'   .    \$\$\$          ║\033[1;37m           Time\033[1;31m: \033[1;37m`date`
\033[1;31m   \$\$P      d\$'     ,    \$\$P          ║\033[1;37m            CPU\033[1;31m: \033[1;37m`cat /proc/cpuinfo | grep "model name" | cut -d ' ' -f3- | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10'} | head -1`
\033[1;31m   \$\$:      \$\$.   -    ,d\$\$'          ║\033[1;37m         Memory\033[1;31m: \033[1;37m`free -t -m | grep "Mem" | awk {'print $4'}`MB Available, `free -t -m | grep "Mem" | awk {'print $3'}`MB Used, `free -t -m | grep "Mem" | awk {'print $2'}`MB Total
\033[1;31m   \$\$;      Y\$b._   _,d\$P'            ║\033[1;37m      HDD Usage\033[1;31m: \033[1;37m`df -T $HOME | awk '{ SUM += $3} END { printf("%.2f\n", SUM/1024/1024) }'`GB Available, `df -T $HOME | awk '{ SUM += $4} END { printf("%.2f\n", SUM/1024/1024) }'`GB Used, `df -T $HOME | awk '{ SUM += $5} END { printf("%.2f\n", SUM/1024/1024) }'`GB Total
\033[1;31m   Y\$\$.    \`.\`\"Y\$\$\$\$P\"'               ╠═════════════════════════[\033[1;37mUser Data\033[1;31m]═══════════════════════════════════════
\033[1;31m   \`\$\$b      \"-.__                    ║\033[1;37m       Username\033[1;31m: \033[1;37m`whoami`
\033[1;31m    \`Y\$\$b                             ║\033[1;37m      Usergroup\033[1;31m: \033[1;37m$USERGROUP
\033[1;31m     \`Y\$\$.                            ║\033[1;37m     Last Login\033[1;31m: \033[1;37m`last -a $USER | head -2 | awk 'NR==2{print $3,$4,$5,$6}'` from `last -a $USER | head -2 | awk 'NR==2{print $10}'`
\033[1;31m       \`\$\$b.                          ║\033[1;37m       Sessions\033[1;31m: \033[1;37m`who | grep $USER | wc -l`
\033[1;31m         \`Y\$\$b.                       ║\033[1;37m      Processes\033[1;31m: \033[1;37m$PROCCOUNT of `ulimit -u` max
\033[1;31m           \`\"Y\$b._                    ║\033[1;37m        Screens\033[1;31m: \033[1;37m`screen -ls | sed ':a;N;$!ba;s/\\n/ /g'`
\033[1;31m               \`\"\"\"\"                  ║
\033[1;31m                                      ╚═══════════════════════════════════════════════════════════════════════════\e[0m
"
