Surveillance Level:Medium
===
尋找user.txt
---

       1.使用nmap蒐集資訊

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/1bab0ecc-aa6d-4909-a8fb-2ee8e4eddd38)

       2.瀏覽頁面

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/ba421d75-db8c-420a-8343-b43bc1ea7685)

       3.使用gobuster列舉目錄，找到admin目錄是一個登入畫面

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/a91647db-f615-435f-8c1c-6334a8145371)
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/92fb70d8-3ba8-41e3-b9bc-39383174eab4)

       4.網站運行Craft CMS並獲得CMS版本
       
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/7360ed1c-96b0-480f-ac43-a87c1ebdfe1d)

       5.找到關於CMS version漏洞
       
[CVE-2023-41892-POC](https://gist.github.com/zhsh9/ae0d6093640aa5c82c534ebee80fa1df)
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/11a6e496-2be6-49ba-bfab-21d3fb08f15a)

       6.執行POC獲取shell
       
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/c1eb3f9e-e1bc-49d7-b514-225e46b88867)
**python3 -c "import pty;pty.spawn('/bin/bash')"**

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/9463e5fb-1f81-413d-8e21-fa11a460b01f)

       7.取得資料庫壓縮檔

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/8f32ead5-d3ce-4459-949f-f1f12494bafa)

       8.檢視資料庫檔案

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/134199fe-7f1f-40a6-b4d5-8d92918635bb)

       9.取得帳號matthew密碼hash並破解

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/387c9a4e-28c4-4736-b670-3f95ae91214b)
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/f35ee204-5bfe-4676-97b9-dfad4fd96ba1)

       10.登入ssh尋找user.txt
       
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/d4f9f849-a77c-4d6c-a95c-5796fdd032f5)

尋找root.txt
---

       11.使用sudo -l沒有任何權限，使用netstat發現listen 8080

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/dbf7e56c-992c-4d32-ace1-3b1545274f85)

       12.內網有8080猜測有內網網站，對8080進行proxy，發現是一個ZoneMinder登入頁面

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/5944cf26-422e-4427-961d-1f449b687815)

       13.ZoneMinder版本有漏洞

[POC for CVE-2023-26035](https://github.com/rvizx/CVE-2023-26035)
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/bba899c1-02e1-43d5-89f0-83c36e95cd39)

       14.執行script取得shell

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/d4832d86-8df5-415a-b8d4-5806f1bf52d6)

       15.在/etc/zm/zm.conf找到DB密碼

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/4ae26ac4-8f87-45b0-8698-5c7e199573a5)

       16.
