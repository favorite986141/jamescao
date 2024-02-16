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

5.找到另一個CVE POC，使用exploit.py reverse shell

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/2c6619b3-80fa-4665-9488-8133ebfd4080)

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/f635049d-75a4-4c94-b723-0a1ad91788b0)

6.找到user.txt

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/2fd109cf-b3c2-4319-94c0-3d881b838e94)

尋找root.txt
---
7.搜尋到AdminUserLoginData.xml，內容包含login id和password屬性

ofbiz/framework/resources/templates」目錄是OFBiz框架內的特定目錄結構 

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/a9365a71-8ad0-4b4e-b8f8-c4ce7d5ec48e)

8.到/opt/ofbiz/runtime/data/derby/ofbiz/seg0，發現很多dat

為什麼會翻到這個路徑/opt/ofbiz/runtime/data/derby/ofbiz/seg0，因為shell一進來的/opt/ofbiz是Apache OFBiz的安裝目錄，/runtime/目錄是儲存資料文件，包含Derby資料庫文件，/seg0/是子目錄

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/d5014763-9ce9-4646-b068-d9986aefbdbc)

9.搜尋password找到hash

       grep -arin -o -E '(\w+\W+){0,5}password(\W+\w+){0,5}' .

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/a04fbd62-3c48-4b39-917b-f7db87829848)

10.根據Apache OFbiz的官方文件（實際上是原始碼中的HashCrypt.java）

https://github.com/apache/ofbiz-framework/blob/trunk/framework/base/src/main/java/org/apache/ofbiz/base/crypto/HashCrypt.java

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/97a43e45-8c24-4f95-8402-587d0a33e5ed)

加密結果採用了encodeBase64URLSafeString()方法對hash資料進行了編碼。而根據apache公告代碼API顯示： 

https://commons.apache.org/proper/commons-codec/apidocs/org/apache/commons/codec/binary/Base64.html

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/4f40b52d-6b89-49fe-86e0-940e2e9a0eb2)

urlSafe - 我們不發出“+”和“/”，而是分別發出“-”和“_”。

11.將取得的Hash - _ 替換成+ / 再透過 CyberChef轉換成16進制

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/7cea8d5c-b580-4bff-b80c-40923acb5a91)

12.使用hashcat破解該密碼。需要在後面加上鹽： hash:salt，取得密碼

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/83089766-adfe-4887-b767-d58e164e592c)

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/0aea3425-a747-4753-b222-23f57e017c4a)
