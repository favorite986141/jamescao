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
    ssh -R *:8008:192.168.0.24:80 administrator@192.168.0.70
    先在 192.168.0.70 開啟 GatewayPorts 的設定，不然沒法讓人家連 8008 port
    sudo nano /etc/ssh/sshd_config
    sudo service ssh restart
![image](https://github.com/user-attachments/assets/f86f24b5-d46b-4093-8bf3-2c093b1b1ba5)
![image](https://github.com/user-attachments/assets/97129812-5fa9-4785-8989-a1aa5039e907)
![image](https://github.com/user-attachments/assets/4410ecea-4aa3-4ed0-b68e-08bc3f9b5710)

