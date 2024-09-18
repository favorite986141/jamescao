Day1
===
Host Discovery: IP (arp, icmp, 25, 80, 445, 3389)
---
  sudo nmap –n –sn –PS22,80,445,3389 192.168.0.* –oG - |grep Up | cut –d" " –f2 > iplist
