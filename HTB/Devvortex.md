Devvortex 
===
尋找user flag
---
    1.使用nmap對靶機進行scan
    
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/38f3f73d-6a71-4df4-a9ea-7157bd29316c)

    2.將devvortex.htb加入/etc/hosts
    
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/85796978-52fa-40a1-a664-553e6e6db79e)

    3.瀏覽http://devvortex.htb/

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/c3dbd0b5-2141-4e37-8272-20c5e5f28171)

    4.使用gobuster進行URL枚舉

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/fb578784-1abe-4a12-a4ee-4a4de249460c)

    5.發現dev.devvortex.htb並加入到/etc/hosts

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/c9c5ad0d-8f5e-4723-9800-71dcdfb35dbb)

    6.瀏覽http://dev.devvortex.htb/

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/24e738e5-ba3f-412c-97cc-3b62e8e3233e)

    7.在對http://dev.devvortex.htb/ 進行枚舉並找到administrator
    
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/6e892541-17c1-49ac-b5b2-4a9dec27ad8c)

    8.瀏覽http://dev.devvortex.htb/administrator/發現是一個joomla平台的後台登入頁面

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/d8243b32-6398-4f44-8b9c-886ccb5b5e2e)

    9.使用JoomScan工具探測Joomla資訊，發現到使用Joomla 4.2.6漏洞版本

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/8a7a4a19-713b-4860-9d96-d0a95e17e252)

    10.找到github的漏洞資訊
[CVE-2023-23752](https://github.com/Acceis/exploit-CVE-2023-23752/tree/master)

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/c319b22c-8b56-417c-b055-86f8f5692016)
    
    11.利用漏洞找出帳號、密碼

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/0b041e8d-ed12-4648-8498-ad6957dc0e68)

    12.使用尋找到的帳號密碼登入後台
    
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/0f4c3873-b878-47e6-99c8-87b102ae58e8)

    13.由於登入是administrator權限，我們可以透過Template在index.php插入php reverse shell
  [shell](https://gist.github.com/rshipp/eee36684db07d234c1cc)  

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/90022bab-027b-4af8-9b1a-d5e633337c49)

    14.Client使用netcat，當插入shell按下儲存後就會執行

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/a6b70d3c-3b17-4c9a-884f-f871244d8975)


