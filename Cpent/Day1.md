<img width="396" alt="image" src="https://github.com/user-attachments/assets/731c9276-6912-4662-a104-3026a5ed4111">Day1
===
Host Discovery: IP (arp, icmp, 25, 80, 445, 3389)
---
    sudo nmap –n –sn –PS22,80,445,3389 192.168.0.* –oG - |grep Up | cut –d" " –f2 > iplist
    利用常見的連接埠探測機器是否有開啟這些連接埠
<img  alt="image" src="https://github.com/user-attachments/assets/20801a33-6b66-4cc0-b612-f9983fd3ae7b">
**補充**
