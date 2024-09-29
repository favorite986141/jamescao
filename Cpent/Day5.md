Day5
===
ADRecon
---
    蒐集AD資訊，下載ADRecon工具
[ADRecon工具](https://github.com/adrecon/ADRecon)
![image](https://github.com/user-attachments/assets/b3735d89-1269-4271-a994-8b2bb5b57117)

    執行powershell&ADRecon.ps1
    powershell.exe  –ep bypass
    > in Domain
    ./adrecon.ps1
    > OR Not in Domain
    ./adrecon.ps1 -DomainController 192.168.177.19 –OutputType ALL -Credential lpt.com\cpent
    > OR
    ./adrecon.ps1 -DomainController 192.168.177.19 –OutputType HTML -Credential lpt.com\cpent
![image](https://github.com/user-attachments/assets/63813ab0-0e04-42ef-8f18-86b36605c65a)
![image](https://github.com/user-attachments/assets/12ddffa2-2bf4-4b03-871f-b53ef80c8687)
