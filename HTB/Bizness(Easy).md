Bizness Level:Easy
===
尋找user.txt
---
1.使用Nmap掃描，目前有開啟22，80，443

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/cc624852-ec0d-4c6f-b58d-e5dd9cfa5430)

2.輸入IP進入到網站

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/f4c4f7b8-9a61-4992-95f5-bf19aafb6c76)

3.使用dirbuster爆破目錄，找到登入畫面

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/0b8bdab0-2f46-42a6-8f02-aafab0ad2b67)
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/96a7e3fd-3b7e-4daa-a853-2df11db01b15)

4.找到OFBiz相關CVE，使用CVE-2023-514467.py確認有弱點

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/37d73a71-2a9f-4d15-a9c7-eef46180fdf3)

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/037a5768-e02c-4fa6-8e7d-5a3a87f66741)

5.找到另一個CVE POC

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/2c6619b3-80fa-4665-9488-8133ebfd4080)
