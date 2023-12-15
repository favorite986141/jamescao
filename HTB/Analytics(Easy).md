Analytics Level:Easy
===
尋找user.txt
---
    1.執行nmap對目標進行掃描

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/6b079ac5-2f6b-47c0-a0f6-b69bd342dd1c)

    2.將analytical.htb加入到/etc/hosts

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/0e94d1f6-f1bd-4d9a-a9aa-26037e0c7c67)

    3.發現到有一個Login的頁面
    
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/943a500c-131c-46a7-bb5f-39089fac4034)
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/8c1ad22b-dde3-4698-8e0c-3a9e6e3fdf36)

    4.尋找有關Metabase的漏洞，利用metasploit尋找相關漏洞

[CVE-2023-38646](https://blog.assetnote.io/2023/07/22/pre-auth-rce-metabase/?source=post_page-----8cf81fa970ca--------------------------------)

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/9a0a6421-1a4e-4940-83c8-90a6104c196a)

    5.使用Metabase漏洞模組
    
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/0e8fb27f-92ac-4b7d-af1c-872fea2a549d)
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/7e671ff0-1f55-4aa4-abc7-0e31ad1282fb)
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/241aae1a-1f9b-46b0-8638-55e01e511ed2)

    6.透過鍵入 env 指令檢查是否有任何環境變數

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/9bb94f5b-aaa2-45ba-b2fc-57fc53d49892)

    7.取得帳號密碼登入SSH取得user.txt

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/9a3fd327-efb9-436a-affe-bff3ea7a563a)

尋找root.txt
---

    8.22.04.2-Ubuntu有提權漏洞
    
[CVE-2023-2640-CVE-2023-32629](https://github.com/g1vi/CVE-2023-2640-CVE-2023-32629/blob/main/README.md)
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/d04cd39b-2b4b-4789-9319-9d1a069a31a0)

    9.使用exploit.sh進行帳號提權

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/b77d37f9-eb26-4c5e-ba66-d5da91d9dcc7)

    10.取得root.txt
    
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/ba776b2b-0e71-42c0-aa52-9e544f2351a9)





