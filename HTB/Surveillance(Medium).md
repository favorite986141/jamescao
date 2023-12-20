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

       9.取得admin帳號和密碼hash

