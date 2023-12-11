 Hospital   Level:Medium 
 ===
尋找user.txt
---

        1.從執行nmap開始，參雜了Linux和MS似乎必須破解linux進而攻擊MS
        
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/08b08ee1-d901-4ff1-a3c5-ef97a42c2f90)

**Make sure add hospital.htb in your host file with the Machine IP.**
       
        2.首先瀏覽443發現是一個web mail，再來瀏覽8080是一個管理後台

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/579e673d-3576-4f71-885a-514671f70e3c)
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/30f7cc70-d7e1-4653-845e-cc5b824be4a4)

        3.在管理後台新建一個帳號登入，是一個上傳檔案的網頁

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/3dc803ce-b1a5-445c-bb7d-b2865493a1c0)

        4.嘗試上傳圖片顯示(success)，上傳shell(error)
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/3a187ba4-4909-491a-b3a4-1b7ce2ff4f62)

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/3ffc1f3f-0ce9-46ec-9812-6d5ec621d10d)
