Day3
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

