Analytics Level:EASY
===
尋找user.txt
---
    1.執行nmap對目標進行掃描

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/6b079ac5-2f6b-47c0-a0f6-b69bd342dd1c)

    2.將analytical.htb加入到/etc/hosts

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/0e94d1f6-f1bd-4d9a-a9aa-26037e0c7c67)

    3.發現到有一個Login的頁面

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/8c1ad22b-dde3-4698-8e0c-3a9e6e3fdf36)

    4.尋找有關Metabase的漏洞，利用metasploit尋找相關漏洞

[CVE-2023-38646](https://blog.assetnote.io/2023/07/22/pre-auth-rce-metabase/?source=post_page-----8cf81fa970ca--------------------------------)

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/9a0a6421-1a4e-4940-83c8-90a6104c196a)

    5.使用Metabase漏洞模組
    
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/0e8fb27f-92ac-4b7d-af1c-872fea2a549d)
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/7e671ff0-1f55-4aa4-abc7-0e31ad1282fb)
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/241aae1a-1f9b-46b0-8638-55e01e511ed2)
