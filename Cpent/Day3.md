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
