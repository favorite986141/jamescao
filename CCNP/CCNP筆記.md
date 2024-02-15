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
 
 Point-to-Multipoint Non-Broadcast
 
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

12.LISP(Locator/ID Separation Protocol):使用動態隧道封裝方法，而不需要預先設定隧道端點。它設計用於在多宿主環境中工作，並支援 LISP 和非 LISP 站點之間的通訊以實現互通。
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/a7675df4-3491-4e1f-b462-3cdb81e9c4af)

13.YANG data models:資料模型分為兩部分：資料模型的第一部分定義了網路資料模型，該模型支援定義網路層次結構或網路堆疊（即，彼此分層的網路）和維護清單網路中包含的節點。資料模型的第二部分以描述拓樸資訊的資訊增強基本網路資料模型。

NETCONF 的最低層是安全傳輸層，強制實現的安全傳輸是 Secure Shell (SSH) [RFC6242]。最低的 RESTCONF 層是 HTTPS，強制實施的安全傳輸是 TLS [RFC5246]。

14.Which HTTP status code is the correct response for a request with an incorrect password applied to a REST API session?

HTTP Status Code: 401

15.The login method is configured on the VTY lines of a router with these parameters. 

. The first method for authentication is TACACS 

. If TACACS is unavailable, login is allowed without any provided credentials 

Which configuration accomplishes this task?

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/0925247a-7284-446a-9536-c68a7a961a98)

16.RP(Rendezvous Point): required only in networks running Protocol Independent Multicast sparse mode (PIM-SM)

By default, the RP is needed only to start new sessions with sources and receivers.

17.To increase total throughput and redundancy on the links between the wireless controller and switch, the customer enabled LAG on the wireless controller. 

Which EtherChannel mode must be configured on the switch to allow the WLC to connect?

have LAG on WLC, then ETHERCHANNEL must be configured **on** the switch Wireless LAN Controller 

18.Which feature does Cisco TrustSec use to provide scalable, secure communication throughout a network?

security group tag number assigned to each port on a network

19.An engineer configures a WLAN with fast transition enabled. Some legacy clients fail to connect to this WLAN.

Which feature allows the legacy clients to connect while still allowing other clients to use fast transition based on their OUIs?

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/4cd64bb2-fcda-463f-9613-e6c0f47f81e7)

20.Which exhibit displays a valid JSON file?

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/597ddaca-9a82-4705-9818-3873955624ad)

21.A network administrator is implementing a routing configuration change and enables routing debugs to track routing behavior during the change. The logging output on the terminal is interrupting the command typing process.

Which two actions can the network administrator take to minimize the possibility of typing commands incorrectly?

Configure the logging synchronous command under the vty. 

Press the TAB key to reprint the command in a new line. 

22.SNR(Signal to Noise Ratio)is comprised of 2 values

a) Signal

b) Noise

RSSI (Received Signal Strength Indicator) 是訊號值的更常見名稱。這是一個設備正在聆聽另一台設備的強度

noise floor本底噪聲是無線環境中存在的背景噪音水準。它代表所有乾擾訊號、熱雜訊和其他雜訊源的總功率

23.Which statements are used for error handling in Python?

try/except

24.What are two benefits of virtualizing the server with the use of VMs in a data center environment?

reduced rack space, power, and cooling requirements

speedy deployment 

25.Which two steps are required for a complete Cisco DNA Center upgrade?

system update application updates 

Procedure

Step 1

A system update appears on the Software Updates page. Click Update.

Step 2

After the system update is complete, at the top of the Application Updates field, click Download All.

system update application updates 

The packages begin downloading.

Step 3

After the packages are downloaded, at the top of the Application Updates field, click Update All.

The packages begin updating.

Step 4

Ensure that each application has been updated by reviewing its version in the Installed Apps page

26.What is a benefit of data modeling languages like YANG? 

They provide a standardized data structure, which results in configuration scalability and consistency

27.![圖片](https://github.com/favorite986141/jamescao/assets/125249893/69340562-8a62-4025-aa00-769eb80c88de)

{"Name": "Bob Johnson", "Age": 75, "Alive": true, "Favorite Foods": ["Cereal", "Mustard", "Onions"]} 

請注意，在 JSON 中，true 和 false 都是小寫

28.Based on this interface configuration, what is the expected state of OSPF adjacency?

![圖片](https://github.com/favorite986141/jamescao/assets/125249893/62d2b0ee-14c1-4409-b9df-5d53e3a0a285)

not established

- Hallo & Dead timer must match
                                                                                                 
- Area id must match
  
- Auth type & Auth Data must match
  
- Subnet mask must match
  
- MTU Size must match
  
- Stub Flag must match
  
- Router ID must not match

29.![圖片](https://github.com/favorite986141/jamescao/assets/125249893/5de43ef9-7d54-4bd2-9baa-6db9162fc1fa)

Link1 is a copper connection and Link2 is a fiber connection. The fiber port must be the primary port for all forwarding. The output of the show spanning-tree command on SW2 shows that the fiber port is blocked by spanning tree. An engineer enters the spanning-tree port-priority 32 command on G0/1 on SW2, but the port remains blocked.

Which command should be entered on the ports that are connected to Link2 to resolve the issue?

每當接收相同通告成本並想要選擇 RP 的兩個連接埠上發生平局時，從具有較低優先權的上游交換器連接埠接收 bpdu 的連接埠將贏得競爭並成為根連接埠。

Enter spanning-tree port-priority 32 on SW1.

30.![圖片](https://github.com/favorite986141/jamescao/assets/125249893/b708813b-eaba-431d-9dfe-daa1702f40cb)

{“switch”: {“name”: “dist1”, “interfaces”: [“gig1”, “gig2”, “gig3”]}} 

31.What are two common sources of interference for Wi-Fi networks?

radar

rogue AP

32.When using TLS for syslog, which configuration allows for secure and reliable transportation of messages to its default port?

logging host 10.2.3.4 vrf mgmt transport tcp port 6514 
![圖片](https://github.com/favorite986141/jamescao/assets/125249893/2485c593-132b-4723-9f67-686d9b3492d9)
