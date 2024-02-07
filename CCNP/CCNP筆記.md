CCNP筆記
===
1.Fabric Edge Node：Fabric邊緣節點負責接納、封裝/解封裝和將流量轉送到連接到交換矩陣邊緣的端點或從端點轉送流量
     
2.Default Privilege Levels:最低特權等級是等級 0。這是 1 和 15 以外在 Cisco 路由器上預設配置的唯一其他等級。
等級 1，即預設使用者等級。此等級為使用者提供了更多命令，允許使用者顯示路由器資訊、遠端登入其他系統以及使用 ping 和 Traceroute 測試網路連線。
預設未啟用的等級 2 新增了一些額外的 show 和clear 指令，但不為使用者提供重新設定路由器的機會。
等級15，允許完全存取所有路由器命令。

3.RIB(Routing Information Base)找尋最佳路徑，FIB(Forwarding Information Base)將最佳路徑組成一個表格

4.Ansible-managed node:IT 自動化引擎，可自動執行雲端配置、應用程式部署和許多其他IT 需求，並藉由 SSH 和 Python 進行溝通。

5.enterprise SSID hidden防止透漏SSID在WIFI清單中，所以會看不到SSID，除非先前有使用過 

6.FlexConnect mode:Client能夠透過廣域網路 (WAN) 連結從公司辦公室配置和控制分公司或遠端辦公室的存取點，而無需在每個辦公室部署控制器。
       FlexConnect 存取點可在本機切換用戶端資料流量，並在與控制器的連線遺失時在本機執行用戶端驗證。當它們連接到控制器時，它們還可以將流量發送回控制器。

7.OSPF 有 5 種網路類型:
 Non-Broadcast
 Boadcast
 Point-to-Multipoint
 oint-to-Multipoint Non-Broadcast
 Point-to-Point
 哪些 OSPF 網路類型相容並允許透過兩個對等設備進行通訊？broadcast to nonbroadcast 

8.NGFW FTD
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/83a49b5e-efcc-42d4-b5a4-fc5edd47c0f6)

9.VRF 是 IP 路由的擴展，提供多個路由實例。它提供了一個獨立的IP路由和轉發表到每個 VPN，並與 MP-iBGP（多協定內部BGP）在提供者設備 (PE) 路由器之間提供第 3 層 MPLS-VPN
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/caa6dfb5-04ac-4597-98ea-1461c87806fa)

10.Cisco TrustSec:
分類和策略執行功能嵌入在Cisco® 交換、路由、無線 LAN 和防火牆產品。
透過流量分類基於端點與其 IP 位址的上下文身份，Cisco TrustSec為動態網路環境和資料提供更靈活的存取控制中心。

11.![圖片](https://github.com/favorite986141/jamescao/assets/125249893/088dd7b1-93db-4d81-bef2-b9f566421bfa)

The output displays OSPF hello messages which router R1 has sent or received on interface Fa0/1.

12.LISP:使用動態隧道封裝方法，而不需要預先設定隧道端點。它設計用於在多宿主環境中工作，並支援 LISP 和非 LISP 站點之間的通訊以實現互通。
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/a7675df4-3491-4e1f-b462-3cdb81e9c4af)

