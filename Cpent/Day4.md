Day4
===
Check Binary
---
    strings ./crackme0x00a|grep GLIBC 檢查檔案資訊
    file crackme0x00a
![image](https://github.com/user-attachments/assets/94504db6-4f69-4356-a535-a9b9e08ee260)
![image](https://github.com/user-attachments/assets/0a47ab25-48c6-4f9c-a951-22e531be0862)

    rabin2拆解檔案內容 rabin2 -z crackme0x00a
![image](https://github.com/user-attachments/assets/916d8ce6-d3c0-4e8e-8677-c093d7a7b13a)

    使用gdb工具進行檔案拆解 gdb crackme0x00a
    
![image](https://github.com/user-attachments/assets/e19147fb-edb6-4dec-8618-0ab95d0bd773)

     disassemble main 
![image](https://github.com/user-attachments/assets/6a4893d2-828a-41ad-bf84-eb122e066542)

    x/s 0x804a024 解出密碼
![image](https://github.com/user-attachments/assets/651b701a-1e4b-490b-8440-666eca76768e)

    設定中斷點並執行
![image](https://github.com/user-attachments/assets/5b9cb403-1d59-4817-bbb5-f39dda6272e2)

    registers資訊，32bit有8個暫存器，64bit有16暫存器
![image](https://github.com/user-attachments/assets/25a6c5f9-d9aa-4564-a819-f83e5d8d7392)

    objectdump -d crackme0x00a or objectdump -d -M intel crackme0x00a
    兩者差異:
    AT&T有百分比，使用()，順序由左到右
![image](https://github.com/user-attachments/assets/7889f175-578d-4f6e-8bee-d13f7a59deb6)
![image](https://github.com/user-attachments/assets/ecc9b364-02c4-46cc-91cb-65ad5679a68e)

