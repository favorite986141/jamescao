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

        4.嘗試上傳圖片顯示(success)，上傳shell(error)，表示有檢查上傳檔案格式
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/3a187ba4-4909-491a-b3a4-1b7ce2ff4f62)

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/3ffc1f3f-0ce9-46ec-9812-6d5ec621d10d)

        5.建立圖片將shell內容key in到圖片裡面並將副檔名改成.phar
[p0wny-shell](https://github.com/flozz/p0wny-shell?source=post_page-----887fd3d6fee9--------------------------------) 

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/2ec5195f-24d4-4f4f-a27e-7529ae92e038)

        6.上傳.phar檔確認成功後，利用Gobuster發現了一個uploads目錄

 ![圖片](https://github.com/favorite986141/jamescao/assets/125249893/5699479d-9295-40ab-ad20-a4b7358bc7de)

        7.在upload找尋上傳的檔案並得到shell頁面

 ![圖片](https://github.com/favorite986141/jamescao/assets/125249893/80bab4d1-07e6-4789-85be-a1aee90f9fee)

        8.嘗試執行指令沒有任何事情發生於是forward到Terminal

 ![圖片](https://github.com/favorite986141/jamescao/assets/125249893/a3933bc2-6344-4c98-894d-734116dae854)

**讓我們使用 Python 產生偽終端實用程式 這將幫助我們完成與 MySQL 所需的所有互動。python3 -c "import pty;pty.spawn('/bin/bash')"**

        9.檢查內核版本有弱點。確認是 5.19.0。所以嘗試這個漏洞利用取得root access
  [CVE-2023-2640-CVE-2023-32629](https://github.com/g1vi/CVE-2023-2640-CVE-2023-32629/tree/main)

  ![圖片](https://github.com/favorite986141/jamescao/assets/125249893/c470d26e-49dc-4a33-acd8-4c2f64cc5b67)
  ![圖片](https://github.com/favorite986141/jamescao/assets/125249893/a149f5c1-79bc-49d1-bdc2-a9de0837dc25)



  
