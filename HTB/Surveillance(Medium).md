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
[CVE-2023-41892](https://gist.github.com/gmh5225/8fad5f02c2cf0334249614eb80cbf4ce)