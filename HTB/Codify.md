Codify
===
尋找user.txt
---
      1.使用nmap進行掃描

   ![圖片](https://github.com/favorite986141/jamescao/assets/125249893/0c00ac91-6a05-4b20-9a49-cd2f7a803930)

      2.使用80 port為進入點，瀏覽網頁

   ![圖片](https://github.com/favorite986141/jamescao/assets/125249893/71fa5ff9-33cd-4343-baf9-9262c677d5ac)

      3.使用 vm2 庫在沙箱環境中運行 Javascript 程式碼。在查找 vm2 庫中的當前漏洞後，我發現了 CVE-2023-30547，它允許攻擊者繞過沙箱限制並在主機環境中執行任意程式碼。
