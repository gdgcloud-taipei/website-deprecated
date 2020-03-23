---
title: '[how-to] 在 GCP 上設定 HTTPS Load Balancer'
date: 2015-05-26T06:03:00.000Z
draft: false
banner: >-
  http://1.bp.blogspot.com/-ATX4eE44cKI/VWPvXEg1KqI/AAAAAAAAva0/PrlWuotndzs/s640/%25E8%259E%25A2%25E5%25B9%2595%25E5%25BF%25AB%25E7%2585%25A7%2B2015-05-26%2B%25E4%25B8%258A%25E5%258D%258810.16.44.png
author: edwardc
translator: null
originallink: null
translatorlink: null
reviewer:
  - GDGCloud Taipei
reviewerlink:
  - null
authorlink: null
summary: >-
  GCP 推出 HTTP Load Balancer 也已經一陣子了，其中類似 anycast 的特性讓後端的 backend server 可以跨不同
  region 之外，也可以根據流量的來源跑到最適合的 backend group 上。  

  但是好用的東西總是缺一味，就是 SSL 的支援。Google 雖然有實作了 HTTPS Load Balancer 但一直都在 alpha
  stage，僅開放邀請測試，所以也都是一整個看的到吃不到的情況 ..  

  日前終於收到 Google 的邀請，終於來試看看到底怎麼設定 HTTPS Load Balancer .. 其實非常簡單 .....
tags:
  - Load Balancer
categories:
  - Load Balancer
  - NETWORKING
keywords:
  - Load Balancer

---

GCP 推出 HTTP Load Balancer 也已經一陣子了，其中類似 anycast 的特性讓後端的 backend server 可以跨不同 region 之外，也可以根據流量的來源跑到最適合的 backend group 上。  
  
但是好用的東西總是缺一味，就是 SSL 的支援。Google 雖然有實作了 HTTPS Load Balancer 但一直都在 alpha stage，僅開放邀請測試，所以也都是一整個看的到吃不到的情況 ..  
  
日前終於收到 Google 的邀請，終於來試看看到底怎麼設定 HTTPS Load Balancer .. 其實非常簡單 .....  
  

[![](http://1.bp.blogspot.com/-ATX4eE44cKI/VWPvXEg1KqI/AAAAAAAAva0/PrlWuotndzs/s640/%25E8%259E%25A2%25E5%25B9%2595%25E5%25BF%25AB%25E7%2585%25A7%2B2015-05-26%2B%25E4%25B8%258A%25E5%258D%258810.16.44.png)](http://1.bp.blogspot.com/-ATX4eE44cKI/VWPvXEg1KqI/AAAAAAAAva0/PrlWuotndzs/s1600/%25E8%259E%25A2%25E5%25B9%2595%25E5%25BF%25AB%25E7%2585%25A7%2B2015-05-26%2B%25E4%25B8%258A%25E5%258D%258810.16.44.png)

  
首先請選擇 HTTP Load Balancing 功能，選擇 New load balancer，輸入名稱  
  

[![](http://3.bp.blogspot.com/-6qUW4hK3CN0/VWPvXEJtZhI/AAAAAAAAvaw/1sVYlA_Etbk/s640/%25E8%259E%25A2%25E5%25B9%2595%25E5%25BF%25AB%25E7%2585%25A7%2B2015-05-26%2B%25E4%25B8%258A%25E5%258D%258810.17.23.png)](http://3.bp.blogspot.com/-6qUW4hK3CN0/VWPvXEJtZhI/AAAAAAAAvaw/1sVYlA_Etbk/s1600/%25E8%259E%25A2%25E5%25B9%2595%25E5%25BF%25AB%25E7%2585%25A7%2B2015-05-26%2B%25E4%25B8%258A%25E5%258D%258810.17.23.png)

  
完成輸入之後，我們來增加新的 forwarding rule  
  

[![](http://1.bp.blogspot.com/-DwHZ-Cxhgo4/VWPvXJNgMhI/AAAAAAAAva4/vpEHv-Qng54/s640/%25E8%259E%25A2%25E5%25B9%2595%25E5%25BF%25AB%25E7%2585%25A7%2B2015-05-26%2B%25E4%25B8%258A%25E5%258D%258810.17.55.png)](http://1.bp.blogspot.com/-DwHZ-Cxhgo4/VWPvXJNgMhI/AAAAAAAAva4/vpEHv-Qng54/s1600/%25E8%259E%25A2%25E5%25B9%2595%25E5%25BF%25AB%25E7%2585%25A7%2B2015-05-26%2B%25E4%25B8%258A%25E5%258D%258810.17.55.png)

  
重點在這裡，如果您的帳號/專案有被加入到這個功能的白名單 (whitelisted) 內，你就可以在 Protocol 那邊看到「HTTPS」，而當你選擇「HTTPS」後，你會看到下方多了一個「Certificate」的下拉式選單，然後選擇「Create a new certificate」  
  

[![](http://2.bp.blogspot.com/-UPcWbjYC684/VWPvXsP7nXI/AAAAAAAAva8/ExKnnAMR6Fc/s640/%25E8%259E%25A2%25E5%25B9%2595%25E5%25BF%25AB%25E7%2585%25A7%2B2015-05-26%2B%25E4%25B8%258A%25E5%258D%258810.24.25.png)](http://2.bp.blogspot.com/-UPcWbjYC684/VWPvXsP7nXI/AAAAAAAAva8/ExKnnAMR6Fc/s1600/%25E8%259E%25A2%25E5%25B9%2595%25E5%25BF%25AB%25E7%2585%25A7%2B2015-05-26%2B%25E4%25B8%258A%25E5%258D%258810.24.25.png)

  
這邊就是新增憑證資訊的頁面，你可以選擇上傳或是貼上憑證的內容。  
其中「Public key certificate」是 CA 所簽發給你的憑證，Certificate chain 就是 CA 給你的中繼憑證 (Intermediate certificate)，然後 Private Key 不意外的就是貼入你申請這個憑證所使用的私鑰。  
  
一旦你的填入憑證是有效的，右方將會出現這個憑證的相關資訊，例如 hostname，有效期限 ... 等等。  
  

[![](http://1.bp.blogspot.com/-mcYijNcG50A/VWPvYKxzNeI/AAAAAAAAvbA/kqyxuntgYu0/s640/%25E8%259E%25A2%25E5%25B9%2595%25E5%25BF%25AB%25E7%2585%25A7%2B2015-05-26%2B%25E4%25B8%258A%25E5%258D%258810.31.04.png)](http://1.bp.blogspot.com/-mcYijNcG50A/VWPvYKxzNeI/AAAAAAAAvbA/kqyxuntgYu0/s1600/%25E8%259E%25A2%25E5%25B9%2595%25E5%25BF%25AB%25E7%2585%25A7%2B2015-05-26%2B%25E4%25B8%258A%25E5%258D%258810.31.04.png)

  
 建立完 forwarding rule 之後，這個 Load Balancer 就完成一半了！這時候你可以直接點那個連結，或是用 curl 檢查 SSL 是否順利掛上你剛剛上傳的憑證。  
  
但因為你現在是用 IP 連，如果用 chrome 連線會得到憑證無效的訊息，因為 IP 跟 hostname 對不上的關係。  

  

[![](http://4.bp.blogspot.com/-2RIqOhoKUZU/VWPvYmfGf7I/AAAAAAAAvbQ/rQGBAbfmVKs/s640/%25E8%259E%25A2%25E5%25B9%2595%25E5%25BF%25AB%25E7%2585%25A7%2B2015-05-26%2B%25E4%25B8%258A%25E5%258D%258811.41.57.png)](http://4.bp.blogspot.com/-2RIqOhoKUZU/VWPvYmfGf7I/AAAAAAAAvbQ/rQGBAbfmVKs/s1600/%25E8%259E%25A2%25E5%25B9%2595%25E5%25BF%25AB%25E7%2585%25A7%2B2015-05-26%2B%25E4%25B8%258A%25E5%258D%258811.41.57.png)

  
或是你也可以進到 advanced view，看剛剛建立的 lb 跟 forwarding rules  
  

[![](http://2.bp.blogspot.com/-CEUOUhJV_yA/VWPvYcr_rkI/AAAAAAAAvbI/tYppFhaa5ss/s640/%25E8%259E%25A2%25E5%25B9%2595%25E5%25BF%25AB%25E7%2585%25A7%2B2015-05-26%2B%25E4%25B8%258A%25E5%258D%258811.41.49.png)](http://2.bp.blogspot.com/-CEUOUhJV_yA/VWPvYcr_rkI/AAAAAAAAvbI/tYppFhaa5ss/s1600/%25E8%259E%25A2%25E5%25B9%2595%25E5%25BF%25AB%25E7%2585%25A7%2B2015-05-26%2B%25E4%25B8%258A%25E5%258D%258811.41.49.png)

  

  
[![](http://4.bp.blogspot.com/-GH4S634JLRI/VWPvYdHhb2I/AAAAAAAAvbE/LYAMBPSx1GE/s640/%25E8%259E%25A2%25E5%25B9%2595%25E5%25BF%25AB%25E7%2585%25A7%2B2015-05-26%2B%25E4%25B8%258A%25E5%258D%258810.31.25.png)](http://4.bp.blogspot.com/-GH4S634JLRI/VWPvYdHhb2I/AAAAAAAAvbE/LYAMBPSx1GE/s1600/%25E8%259E%25A2%25E5%25B9%2595%25E5%25BF%25AB%25E7%2585%25A7%2B2015-05-26%2B%25E4%25B8%258A%25E5%258D%258810.31.25.png)

您也可以到 Certificate 頁籤看看剛剛上傳的憑證相關資訊  
  
  
接下來 HTTPS Load Balancing 已經可以動作嘍！再把後端的 backend service 接上來，就大功告成了！  
  
  
FAQ:  
  
Q: 如果已經有 HTTP Forwarding Rule 了，怎麼辦？我可以把 HTTP 跟 HTTPS 綁在同個 IP 嘛？  
  
A: 當然可以的，要不然這東西還能用嘛 (笑)  
作法在 console 上找不到，這時候請用 gcloud 指令下：  
  

> % gcloud beta compute forwarding-rules create rule-api --global --target\-https\-proxyproxy\-api-https --port-range 443 --adress <原本的 HTTP LB IP>