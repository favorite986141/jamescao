<img width="424" alt="image" src="https://github.com/user-attachments/assets/ec9eedff-8f10-4387-ad05-800749d7f04a">Day1
===
Host Discovery: IP (arp, icmp, 25, 80, 445, 3389)
---
    sudo nmap –n –sn –PS22,80,445,3389 192.168.0.* –oG - |grep Up | cut –d" " –f2 > iplist
    利用常見的連接埠探測機器是否有開啟這些連接埠
<img  alt="image" src="https://github.com/user-attachments/assets/20801a33-6b66-4cc0-b612-f9983fd3ae7b">

**補充**

1.nmap預設只掃1000常用的連接埠
            
2.nmap沒有權限只會進行TCP connect scan只能掃80、443，若要完整的掃描開放端口需加sudo，因要進行SYN掃描要創建數據包，root權限才能創建

    若環境無法安裝nmap可以利用迴圈
    for i in {1..254}; do (ping -c 1 192.168.0.$i | grep "bytes from" &); done
<img  alt="image" src="https://github.com/user-attachments/assets/b5b183ea-2680-48be-bdd7-b5c513864579">

    UDP Scan 可清楚看到137有回應，138可能有開但被過濾,139完全沒有回應

<img alt="image" src="https://github.com/user-attachments/assets/73263ac5-23e4-4f12-82d8-10c4e4fd1e16">

    sudo hping3 192.168.0.7 -n -S -c 3 -p 80，利用hping發送封包

<img  alt="image" src="https://github.com/user-attachments/assets/596f3f6f-44cc-4d4c-871d-62e507fe2501">

Service/OS Discovery
---
        
    sudo nmap -n -p445,3389 -sVC 192.168.0.21，發現此台主機有開啟smb v1
<img alt="image" src="https://github.com/user-attachments/assets/c6494a73-cc45-4c6b-aa4c-b005a88a254e">
    sudo nmap -n --script=smb-vuln-ms17-010.nse 192.168.0.21 使用nmap上的腳本進行scan
<img width="424" alt="image" src="https://github.com/user-attachments/assets/2950f88e-461c-4a1c-ad3d-08a04613a8cc">
