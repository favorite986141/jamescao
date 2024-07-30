Mailling Level:Easy
===
尋找user.txt
---
    1.使用nmpa對目標進行SCAN
  
<img src="https://github.com/user-attachments/assets/1239796e-6ddb-4723-a0cc-5a0e30a0d308">

    2.使用目錄掃描

<img src="https://github.com/user-attachments/assets/b9f64963-b4f8-4f74-aa31-e0e6b05cdbbb">

    3.瀏覽download.php，發現需要參數

<img src="https://github.com/user-attachments/assets/9c3dea0a-ed3d-4c33-b8e1-7a14c9591c6a">

    4.回到主頁有發現一個download的按鈕，透過burp攔截封包內容

<img  src="https://github.com/user-attachments/assets/09f25862-743e-4479-84ff-aef0d048a100">

    5.透過目錄遍歷可以到任意位置讀取檔案，存在任意讀取漏洞

<img  src="https://github.com/user-attachments/assets/f9592bc4-1051-4091-b3a2-045219859815">

    6.因為使用hMailServer服務，透過目錄遍歷漏洞找出設定檔
    
<img  src="https://github.com/user-attachments/assets/e86c8fe2-5786-42ad-b240-0ff938abad23">

    7.識別Hash使用哪一種雜湊並透過john將Hash破解

<img  src="https://github.com/user-attachments/assets/0edfc683-db66-4cdf-86f3-0d34a860505b">
<img  src="https://github.com/user-attachments/assets/dc6c0d2c-63a1-4a9a-8579-1006569be241">

