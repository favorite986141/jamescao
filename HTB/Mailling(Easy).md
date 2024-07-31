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

    14.在destop底下找到user.txt

<img  src="https://github.com/user-attachments/assets/09cd4fdc-f901-4291-a1dd-856e270759e5">

尋找root.txt
---
    15.查看maya帳號權限，沒有可利用的點

<img  src="https://github.com/user-attachments/assets/e36fdae6-d91e-4f2b-9158-955207df2a29">

    16.查看當前目錄底下有mail.py和mail.vbs兩個檔案並觀察這兩個檔案

<img  src="https://github.com/user-attachments/assets/5a8198c1-9b3d-4479-a7d6-67de0408c88f">

    17.查看mail.vbs，該腳本是使用 Windows Script Host (WSH) 編寫的自動化腳本。其具體目的是在Windows環境下操作應用程式和視窗

<img  src="https://github.com/user-attachments/assets/faaf5600-9455-4091-87cb-0e5a61e35f93">

建立Shell物件：Set objShell = CreateObject("WScript.Shell") 
這行程式碼建立了一個 WScript.Shell 對象，該對象允許透過 VBScript 控制和與 Windows Shell 互動進行腳本:objShell.Run "explorer shell:AppsFolder\microsoft.windowscommunicationsapps_8wekyb3d8bbwe!microsoft.windowslive.mail"
使用運行方法開啟 Windows 的郵件應用程式（通常是 Windows 10 郵件應用程式）
等待程式啟動：WScript.Sleep 5000
該行程式碼使腳本暫停執行 5000 毫秒（5 秒），以確保郵件應用程式有足夠的時間啟動
啟動視窗：objShell.AppActivate "Mail"
    
    18.查看mail.py，這個腳本使用 pywinauto 庫模擬了郵件應用的操作，打開收件匣未讀郵件列表並逐次打開條郵件，猜測也是跟這個郵件相關的提權
    
<img src="https://github.com/user-attachments/assets/7dae098f-f8b9-47ad-bb14-e744e30c9642">

    19.查看一下後台任務，schtasks /query /fo LIST /v
    
<img  src="https://github.com/user-attachments/assets/3c7062d8-f4b0-434a-822e-7decb3035ead">

    20.找soffice.ps1的檔案位置，查看內容為執行odt檔

<img  src="https://github.com/user-attachments/assets/95eba55c-b9dd-4b05-9052-e19d6d66cdfd">

    21.查看LibreOffice版本

<img  src="https://github.com/user-attachments/assets/52c7fcb5-901a-42f7-b823-c8304570967e">

    22.確認版本後找尋相關的POC

[CVE-2023-2255](https://github.com/elweth-sec/CVE-2023-2255)
<img  src="https://github.com/user-attachments/assets/3eec236c-8282-4d91-90de-e981bb619d99">

    23.在C底下有一個Important Documents

<img  src="https://github.com/user-attachments/assets/398908db-e6ce-49b0-844f-2c61c64b5b6f">

    24.生成一個Reverse Shell並製作成odt檔上傳到靶機

<img  src="https://github.com/user-attachments/assets/0854faff-9ad6-47a5-b835-494d514d1bb9">
<img  src="https://github.com/user-attachments/assets/6a8cd89d-600f-4c02-b09a-595079dd7342">
<img  src="https://github.com/user-attachments/assets/73efe30e-404b-49b3-b8c0-a382f5421ca3">

