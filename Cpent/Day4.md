Day4
===
關閉ASLR
---
    sysctl -a --pattren randomize
    sysctl -w kernal.randomize_va_space=0
![image](https://github.com/user-attachments/assets/55a72689-b830-4df2-b0c9-99ba9016c66c)

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

shellcode.c編譯&權限
---
    編譯shellcode.c，gcc shellcode.c -o shellcode -z execstack
![image](https://github.com/user-attachments/assets/d2348643-65b5-49db-a3eb-e222cbfad12d)

    執行shellcode
![image](https://github.com/user-attachments/assets/0cc8ebe4-6cfe-4d33-8c42-099e9a1262e1)

    提權&編譯
    加入 
    "\x6a\x17"		
    "\x58"			
    "\x31\xdb"		
    "\xcd\x80"
![image](https://github.com/user-attachments/assets/81e4e9b9-db86-4369-901e-d01c56423dbf)
![image](https://github.com/user-attachments/assets/a0cb0fd6-d96c-4d2e-a3f9-c7b3e9c154fe)

    變更擁有者和執行權限
    sudo chown root:root shellcode
    sudo chmod 4755 shellcode
![image](https://github.com/user-attachments/assets/fea8d6ed-5616-43e9-b6af-fb2b945c1cc4)

    執行確認uid=0(root)
![image](https://github.com/user-attachments/assets/78dcc4d2-c593-4b4b-ae1c-6e9e0d41bae0)

緩衝區益位stack.c
---
    編譯&變更擁有者和權限
    sudo gcc stack.c -o stack -z execstack -fno-stack-protector
    sudo chown root:root stack
    sudo chmod 4755 stack
    execstack 產生一個將堆疊標記為可執行或不可執行的部分
    -fno-stack-protector停用堆疊保護機制。堆疊保護是一項安全功能
![image](https://github.com/user-attachments/assets/9a5495a7-bd64-4f34-b81d-137ecd100c72)
![image](https://github.com/user-attachments/assets/66588ac4-ca39-4068-a785-e9559b93bc95)

    確認程式的保護機制
    checksec
![image](https://github.com/user-attachments/assets/405de152-e622-457f-ae43-a22f15d4bedc)

    反組譯程式碼
    disassemble main
    r
![image](https://github.com/user-attachments/assets/a3b70974-fdd0-4b88-b313-77374af32ad3)

    設定中斷點並找到所需檔名
    b *mian +55
    r
![image](https://github.com/user-attachments/assets/ebbd268b-7a78-43e2-8aad-3d507046e94b)

    建立badfile檔案並執行stack，程式就無報錯
![image](https://github.com/user-attachments/assets/96499010-86b7-4c68-8768-6a24f8ffe981)

    塞值到badfile讓他超出範圍
![image](https://github.com/user-attachments/assets/ed5b17bb-1597-4b8a-9601-8870048f721b)

    找出ret address ESP位置在第42bit
    pattern create 100 badfile
    r
    pattern search
![image](https://github.com/user-attachments/assets/1f3a871b-cf43-4a11-af79-1e3073ecbb10)
![image](https://github.com/user-attachments/assets/bc7a9aba-f6fe-418a-95d9-9e40ca0ec079)

    確認ret address 有塞BBBB的值
![image](https://github.com/user-attachments/assets/ef0644c7-485e-4b11-a945-9e1b38f28a41)
![image](https://github.com/user-attachments/assets/51cadb28-e0cb-494e-b104-9ca1835b2dac)

    將shellcode機器語言塞進去C的位置
    cat shellcode.c | grep '"' | cut -d'"' -f2,4 | tr -d '"' | tr -d '\n'
![image](https://github.com/user-attachments/assets/caa04db4-657e-42c9-b7be-3aa4cad186b1)
![image](https://github.com/user-attachments/assets/f5d740a9-287d-44b0-854d-f06f1c434198)

