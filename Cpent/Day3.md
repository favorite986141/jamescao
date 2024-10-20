![image](https://github.com/user-attachments/assets/eb591005-b71b-4e20-8499-419a6375d2c0)Day3
===
SSH Local Port Forwarding
---
    ssh -L *:80:192.168.0.24:80 administrator@192.168.0.70
    可看到本機開了80 Port，遠端連線到192.168.0.70的22 Port
192.168.0.70
  ![image](https://github.com/user-attachments/assets/61e42d6e-f8b8-47de-9abc-d56f7090acdc)
192.168.0.18
  ![image](https://github.com/user-attachments/assets/5c4571fc-8505-49d2-a1de-5572d43f43d9)

    本機瀏覽器127.0.0.1:80 等於 192.168.0.24:80
![image](https://github.com/user-attachments/assets/62274627-a98b-4007-b9f4-84c034e2292c)

    斷線後就無法連接
![image](https://github.com/user-attachments/assets/896a68c0-6d99-4ef3-82d2-d962411f25db)

SSH Remote Port Forwarding
---
    
    先在 192.168.0.70 開啟 GatewayPorts 的設定，不然沒法讓人家連 8008 port
    sudo nano /etc/ssh/sshd_config
    sudo service ssh restart
![image](https://github.com/user-attachments/assets/f86f24b5-d46b-4093-8bf3-2c093b1b1ba5)
![image](https://github.com/user-attachments/assets/97129812-5fa9-4785-8989-a1aa5039e907)
![image](https://github.com/user-attachments/assets/4410ecea-4aa3-4ed0-b68e-08bc3f9b5710)

    ssh -R *:8008:192.168.0.24:80 administrator@192.168.0.70
![image](https://github.com/user-attachments/assets/97b841a1-8a5c-40e3-941c-34d3395c1ab6)

    可看到本機開了兩條連線22、8008
![image](https://github.com/user-attachments/assets/02c997e5-1fda-452f-942a-c8108074c879)

    192.168.0.70也開了兩條連線22、8008
![image](https://github.com/user-attachments/assets/c18e2dc1-f035-4593-8375-50d0d38cb3af)

    本機瀏覽器192.168.0.70:8008 等於 192.168.0.24
![image](https://github.com/user-attachments/assets/c81457a1-7044-4559-9dd1-3bce1297a362)

    斷線後就無法連線
![image](https://github.com/user-attachments/assets/f1be00ca-09f4-45be-a9d1-88f3a79ef725)

SSH dynamic port forwarding
---
    只要連至.18:9050的網路流量都可以透過.70轉發出去
    ssh administrator@192.168.0.70 -CD 9050
    -C：這個選項啟用了SSH壓縮，以減少資料傳輸時的頻寬使用。 它可以提高資料傳輸的效率。
    -D 9050：這是配置動態連接埠轉送的部分。
![image](https://github.com/user-attachments/assets/41aed900-6f0b-4509-bc6c-768a0189c497)

    .18的連線狀況
![image](https://github.com/user-attachments/assets/d008871f-07f4-4f61-81cb-3ff2e8c09f86)

    透過proxychains轉發流量
    sudo nano /etc/proxychains.conf
![image](https://github.com/user-attachments/assets/eecf5c1e-ca6e-4786-a43e-ef34ebcb15e0)

    proxychains winexe -U 'administrator%Pa$$w0rd' //192.168.0.7 cmd.exe
    通過代理伺服器建立到目標 Windows 主機的遠端連接，然後運行 cmd.exe 命令提示字元，以在遠端主機上執行命令。
![image](https://github.com/user-attachments/assets/ec03da12-0c29-40c3-a6e5-bcf228d8a7ae)

    proxychains xfreerdp /v:192.168.0.7 /u:administrator /p:'Pa$$word' /size:90%
    建立到目標 Windows 主機的遠端桌面連接，並以 administrator 用戶登錄，然後調整遠程桌面窗口大小。
![image](https://github.com/user-attachments/assets/8850d77e-3c7b-441b-a583-6952df85127b)

SSH Local Port Forwarding /w Jump Host
---

    ssh -J administrator@192.168.0.70 administrator@192.168.0.10 -L *:80:192.168.0.24:80
    先跳到192.168.0.70在透過192.168.0.10連到192.168.0.24的80 Port
![image](https://github.com/user-attachments/assets/2ee86876-47e8-4aef-82eb-ea71275ae550)

    本機只會看到連線192.168.0.70 22 Port
![image](https://github.com/user-attachments/assets/1dd6e2e8-2e17-4918-bae4-4df6107ca3d4)

    192.168.0.70只看的到連線192.168.0.10 22 Port
![image](https://github.com/user-attachments/assets/6520cd19-e929-4d41-8ea6-767d3746af87)

    瀏覽本機瀏覽器127.0.0.1:80可連接到192.168.0.24的80
![image](https://github.com/user-attachments/assets/0e51a666-bc4b-4f95-850e-0785a8fc553b)

    斷開連線後就無法連線
![image](https://github.com/user-attachments/assets/5e11cc9b-2d0d-4f57-8534-5a1065658791)



