Codify
===
尋找user.txt
---
      1.使用nmap進行掃描

   ![圖片](https://github.com/favorite986141/jamescao/assets/125249893/0c00ac91-6a05-4b20-9a49-cd2f7a803930)

      2.使用80 port為進入點，瀏覽網頁

   ![圖片](https://github.com/favorite986141/jamescao/assets/125249893/71fa5ff9-33cd-4343-baf9-9262c677d5ac)

      3.使用 vm2 庫在沙箱環境中運行 Javascript 程式碼。在查找 vm2 庫中的當前漏洞後，發現了CVE-2023-30547，它允許攻擊者繞過沙箱限制並在主機環境中執行任意程式碼。

   [CVE-2023-30547](https://gist.github.com/leesh3288/381b230b04936dd4d74aaf90cc8bb244)

      4.在runtime環境下執行POC指令測試使用cat /etc/passwd

   ![圖片](https://github.com/favorite986141/jamescao/assets/125249893/13170605-5477-4863-8cbc-ff48a9a65ee7)

      5.使用reverse shell

   ![圖片](https://github.com/favorite986141/jamescao/assets/125249893/0ed4a6d2-aa3c-45e2-af79-f4b7d588acf9)

      6.進入/var/www/contact目錄，檢視tickets.db拿到joshua密碼HASH

   ![圖片](https://github.com/favorite986141/jamescao/assets/125249893/bfb6ea03-f494-4d0b-b431-dc358a937d1d)

      7.破解密碼HASH後，登入joshua

   ![圖片](https://github.com/favorite986141/jamescao/assets/125249893/87abbb76-f893-427a-a1cc-83caa6844a99)

      8.拿到user.txt

   ![圖片](https://github.com/favorite986141/jamescao/assets/125249893/f499abca-2b8a-4ec8-a720-1e8c7119eaa4)

尋找root.txt
---

      9.執行sudo -l 確認可執行指令

   ![圖片](https://github.com/favorite986141/jamescao/assets/125249893/35fecdc5-8641-422f-aeed-82fb65c52c04)

      10.分析mysql-backup.sh內容

   ![圖片](https://github.com/favorite986141/jamescao/assets/125249893/fcc7ea94-9229-405b-a45d-912a4fef8cf9)

      11.腳本的這一部分將使用者提供的密碼 (USER_PASS) 與實際資料庫密碼 (DB_PASS) 進行比較。這裡的漏洞是由於 Bash 中 [[ ]] 內部使用了 == ，它執行模式匹配而不是直接字串比較。
      這意味著使用者輸入 (USER_PASS) 被視為一種模式，如果它包含像 * 或 ? 這樣的全域字符，它可能會匹配意外的字串。
      例如，如果實際密碼（DB_PASS）是password123，並且使用者輸入*作為其密碼（USER_PASS），則模式匹配將成功，因為*匹配任何字串，從而導致未經授權的存取。
      這意味著我們可以暴力破解 DB_PASS 中的每個字元。
