Day1
===
Host Discovery: IP (arp, icmp, 25, 80, 445, 3389)
---
    sudo nmap –n –sn –PS22,80,445,3389 192.168.0.* –oG - |grep Up | cut –d" " –f2 > iplist
<img width="396" alt="image" src="https://github.com/user-attachments/assets/20801a33-6b66-4cc0-b612-f9983fd3ae7b">
