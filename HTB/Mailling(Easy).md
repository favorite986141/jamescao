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

    8.使用先前Nmap掃到110進行認證測試，確認可以登入憑證有效

<img  src="https://github.com/user-attachments/assets/4c391322-5d58-468e-b0a7-b78e5ad9f693">

    9.確認憑證有效，可透過強制訪問responder來獲取NTLM，這裡牽涉到CVE-2024-21413此漏洞腳本可以使用SMTP驗證發送電子郵件，繞過SPF、DKIM和DMARC檢查
[CVE-2024-21413](https://github.com/xaitax/CVE-2024-21413-Microsoft-Outlook-Remote-Code-Execution-Vulnerability?tab=readme-ov-file)

<img  src="https://github.com/user-attachments/assets/739f40dc-9f3d-4673-80ed-75903c4a6d8f">

    10.在本地啟用responder

<img  src="https://github.com/user-attachments/assets/4edd12c0-7602-4fc9-8c13-83ff90395d9a">

    11.在下載的PDF會提到Maya會閱讀郵件，透過CVE-2024-21413的POC發送惡意連結發給Maya，當Maya點擊連結會獲取Maya帳戶的NTLM
    
<img  src="https://github.com/user-attachments/assets/1bd97ee7-329a-4420-80e3-9bf74c0f5d03">
<img  src="https://github.com/user-attachments/assets/2f3db44e-bbde-4410-9722-ade2577b0b98">
<img  src="https://github.com/user-attachments/assets/b1572ab4-f621-44c3-9016-ed08d4088944">

    12.拿到Maya帳號的Hash，先識別類型然後進行破解
    
<img  src="https://github.com/user-attachments/assets/ff2960b1-92e4-4ab2-8852-36619168a330">
<img  src="https://github.com/user-attachments/assets/72c39a87-4ed9-4eee-8227-45e99f3eed9a">

    13.使用evilwinrm進行登入maya帳號

<img  src="https://github.com/user-attachments/assets/9f175d98-962f-4a52-98f7-35e0264c1ca7">
