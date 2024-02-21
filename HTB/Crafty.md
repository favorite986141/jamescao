Crafty Level:Easy
===
尋找user.txt
---
    1.執行Nmap蒐集資訊
    
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/2818b273-5925-4520-be74-b2630292fae0)

    2.目錄列舉，發現一個js資料夾是403

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/f5b4d0b6-d52e-48ea-9c03-ed9bf1a63722)

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/711cd664-28f2-46c3-b9ab-72df376aa95f)

    3.在使用dirbuster列舉，發現js資料夾裡面有main.js

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/e5673fc1-5556-4cf8-ad8b-2bd90a58b769)

    4.開啟main.js，有一段內容引人注目
    
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/a3c42d5c-3937-4ac7-982e-0e4bf796c188)

這段程式碼主要功能是取得和顯示一個遊戲伺服器上的線上玩家數量。大概指的是mc伺服器，它透過定期查詢一個外部API來實現這一點，裡面運用了**updatePlayercount函數，**先是向https://api.bybilly.uk/api/players/${ip}/ ${port}發送一個GET請求，查詢指定IP和端口的遊戲伺服器的在線玩家數量，如果返回的是online，則顯示在.sip裡面，如果不返回online，說明斷線了，然後會在.playercount中顯示相應的信息，並使用setInterval設置一個定時器，每60秒調用一次updatePlayercount函數以定期更新玩家數量，裡面的是25565端口值得是mc的默認端口，這次利用log4j的poc來反彈shell，這次利用的是CVE-2021-44228編號的poc（也稱為Log4Shell漏洞）

    5.找到Log4Shell POC，執行前先下載jdk並變更檔名為jdk1.8.0_20
[CVE-2021-44228](https://github.com/kozmer/log4j-shell-poc)

[jdk](https://repo.huaweicloud.com/java/jdk/8u181-b13/jdk-8u181-linux-x64.tar.gz)

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/216407a1-9d28-4028-87dd-07ea685ce016)

    6.修改poc.py，因系統為Windows所以改成cmd.exe
    
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/6fd8f14f-7aa9-4cac-afb0-e598f6603cd4)

    7.執行poc.py，會產生一組LDAP位置

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/066b4a78-ee68-4dd8-9260-763098dc1745)

    8.下載mc工具
[mc工具](https://github.com/ammaraskar/pyCraft)

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/b7d546bd-d42f-483b-81d7-24f192eb4cc6)

    9.
    
