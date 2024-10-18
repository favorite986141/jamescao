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

