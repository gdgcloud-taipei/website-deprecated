---
title: "Google Cloud Launch 的 Percona 服務介紹"
date: 2017-08-20T07:53:00-07:00
draft: false
banner: "https://lh5.googleusercontent.com/3Bzd2GwiyjXU0g-e8di6-aCvI1EYwSUlIJwdJYbGWPRt_rCl_5a_HX4Hfm50My4gcNq1SCxIRviiUHwPVU1MgrTFOrXPNIdJ4lrDuA9zRElSXPzwIi8ss5_UUtc9TwUKD2fbklqq"
author: "Simon Su"
translator: ""
originallink: ""
translatorlink: ""
reviewer:  ["GCPUG.TW"]
reviewerlink:  [""]
authorlink: ""
summary: "Database一直是每一項服務需要特別花心思的地方，通常將資料庫服務委託給Google CloudSQL是最簡單不過的，不過，如果希望能夠保有對資料庫的完整操控權，則自建Database是最快的選擇... 而Google Cloud Launcher服務即有DB Cluster的建置，在此以Percona Cluster為例，透過Cloud Launcher簡單的建置Percona MySQL Cluster…"
tags: ["google cloud luanch"]
categories: ["luancher"]
keywords: ["google cloud luanch"]
---

Database一直是每一項服務需要特別花心思的地方，通常將資料庫服務委託給Google CloudSQL是最簡單不過的，不過，如果希望能夠保有對資料庫的完整操控權，則自建Database是最快的選擇... 而Google Cloud Launcher服務即有DB Cluster的建置，在此以Percona Cluster為例，透過Cloud Launcher簡單的建置Percona MySQL Cluster…

Percona是分支自MySQL的資料庫，相較於原生MySQL，Percona原生提供了更多的資料庫工具，讓使用者可以更快速的建置自己的MySQL應用...

首先，我們先到Cloud Lancher ( [https://console.cloud.google.com/launcher](https://console.cloud.google.com/launcher) ) 搜尋”Percona”關鍵字，然後進入Percona的說明頁面之後點選LAUNCH ON COMPUTE ENGINE...

![](https://lh5.googleusercontent.com/3Bzd2GwiyjXU0g-e8di6-aCvI1EYwSUlIJwdJYbGWPRt_rCl_5a_HX4Hfm50My4gcNq1SCxIRviiUHwPVU1MgrTFOrXPNIdJ4lrDuA9zRElSXPzwIi8ss5_UUtc9TwUKD2fbklqq)

依照GCP上的建議，Percona Cluster 預設啟動的機器不能小於三台，我們可以指定資料庫的zone位置，也可以依照需求指定更多的主機數量... 選好機器的zone和數量後，只要點選Deploy，就可以開始進入開通cluster的動作...

![](https://lh4.googleusercontent.com/nFCvX_pFv9cwwkKPxq3JKyjF8vMeAER4JAYhilYL09pvddOMigEzPh0i1TyP7ZalzE4MxYHAREh9OkeJUR97nt-pdQdCh7r4IphQFuFZtkv6vLgQgHnBnlr52NrHzqOdCKmVu50H)

  

建立完成後可以在”Deployment Manager”裡，看到您剛剛建立的Percona，裡面會有每一台機器的說明、DB的password、相關說明文件等資料

![](https://lh3.googleusercontent.com/sBPdRc3UY3r5riEUucnW6YA4IwbKdDJtC2o_noXlJWF8gWmbHnIEtDC2iTwy2_rcsMrifys-FMheV5sXb2Z6fqR1Sf-t3x6l7zCivvRwysHn_uFGw8vhbejY4aRtd-s0PBHyZbh1)

![](https://lh4.googleusercontent.com/9ZO1KH0gOTUmE71pqaqZZWl_kxf_kLE6sZHjgr2b7edpBp8yAZ4VkomkZIzW1OqZgCI7AmWBYoZjhmYdhLYowaVO_V0SgY-ub_Askjhaa2eVYrlDiQC4-zcmug1JAjU6eztJXFzq)

由於Cloud Launcher是以Appliance的方式提供服務，也就是會使用Compute Engine來建置，因此我們會看到剛剛所開立起來的三台機器...

![](https://lh4.googleusercontent.com/ntIn1mYQ42OE4qYmP-tXEKeb8_mnQL7K7MebT6n07bG_qSoTlT-iK815zESqkfNhyj28gSnP2Qromj9On1cBhOJS8XIZ3SmBjB9QNRQXm-XMxRMdT0FFdkRwHR6MBwvXLyfYPZ3e)

  
在Percona的Cluster機制下，所有的主機都是可以讀寫的狀態... 因此，接下來我們可以使用SSH進入機器內檢視，登入後，執行mysql指令連線所建立的資料庫，若執行成功就能開始使用...

![](https://lh4.googleusercontent.com/9Jj_yMC72Zjghq2tDNeYUmogM4x2iLGgIUqixKJW11UXtYi0ws_dO1VDXtcMRkZXjbl5Wor9hds00zt86dSaicekkB9qstsdNbfiVGukjo61yCVhCZeyCL3aKmiyd0HFu86g8luN)

為了求證cluster的運作，以下進行幾個簡單測試..

1. 每一台DB資料是否會同步?

    答案是會~ 在第一台建立一個Database，其他二台會自動sync，如附圖

    ![](https://lh6.googleusercontent.com/C2hbxsp16669mM5mIKlG8rFRT7FCrkZzentykgpUPSbM-tHLzxxokuKRE88-Dwx-zmIZp9gjKV_xHGbTHcnWp9eK9CcvzTWNkeMqTgZqCtoetHOT8__W6tsrJY9XkxDYpgvVI2yA)

    ![](https://lh4.googleusercontent.com/pB1kwbUbX4XzKXLvTdZ1u00AqiM4nnBCCdXKMie1cjjou_5qRU2dli2Ze-6J170t_UTZeGlQtRzYLOd1q0KhKfHSMp1jELNxxzj_UMOWD93ZUKWl7Y4IrcMdNTT0B96ZGeD_VV81)

    

1. 關掉一台，其他台能不能正常運作?

    Step1. Shutdown最後一台機器，在percono1新增一個table並insert資料

    ![](https://lh3.googleusercontent.com/7jCpAREu_cPyZZMMp7I36IyFCtHFzVxuUosHgO8YaIv7ElIquhEJGnKw0h6G414Bf8ne3TnO42auX9YTk5zUnTMqW_jiv6qSIVVVc8Dk6dS1UhZmajkMbVg5RigRCxsG2XHB-ruA)

    還活著的另一台會自動sync資料

    ![](https://lh6.googleusercontent.com/9KrdqiTRXOgkqybGihSeohDNiAp0nHVH4O9mPtspMcY6rbwxslU59-N3RDuYroa2-R8gMbrU8ppeXL366jCznnwbM3SsrrlANk3lijvC7AOmuyo_NGt3ERuvR_nbR3mwML9bHLmJ)

    Step2. 將shutdown的機器重新啟動，檢查是否有同步資料。

    ![](https://lh4.googleusercontent.com/kipbjhb3PyRUfNFWSXhpYh0oSBRz1-rqwnrO59T4WL6jbOBw0jyAw7AtE8YKj--gr5oyL-nyEyH2Scfh7t7jzmYW5fm72to19CIntjNhAti0OQlppZ59sY07jTwBvww73zO7jcP1)

    結論:
    
    關掉一台，其他台可以正常運作；關掉的那台，重新啟動後資料會同步到最新的狀態。


1. 測試binlog可不可以正常回復資料?

    Step1 先在每一台的my.cnf加入幾行binlog設定後，重新啟動MySQL

    ```shell
    log-bin=mysql-bin

    #不同台的server-id要設不一樣的  
    server-id=1  
    #備份天數

    expire-logs-days=7  
    #這個功能可以把其他 Master 讀到的 Binlog 也寫進自己的 Binlog，這樣自己也能變成 Master 讓其他 Slave 節點同步  
    log-slave-updates = 1
    ```

    ![](https://lh6.googleusercontent.com/Thj1rUTn4xdbWCofirbUQyjmkhDbEd8lsjz0lukMiCt-sAnbCcLV379rYAvqlub5IUnMxW58Q8O4FT84YNw_prpYvcnoU7su1UQ57h74ZrY3MdHmG4bymc4uFhxxVMWxqvaJcLfL)

    檢查是否已開啟，ON就是有開啟了

    ```shell
    mysql > show  variables  like  'log\_bin';
    ```

    ![](https://lh6.googleusercontent.com/EWTry5rjt8Fvtzas7qqnE7iGEnOEvpLPq_elD56nWLT2m8FlXbWvLwoUOCUmXB9kAAmZ6tk7yQknt-Lh3KNJZq4Zq5GvMl2wkIu19jfVlZ4T6N9Rn_gWtclkFocNNoucL-JgcQFN)

    檔案會存在/var/lib/mysql下

    ![](https://lh5.googleusercontent.com/e9yLn3h9rCCevtU1BUaNOoBw6cnOb67SF0uM5q9tX_pE_pE1Em-gZJdt8kAtFkuGiwsJpPNSxmTOu_HrddK24fOqcrVblq1gMj_Cg4NaqgcR7OkidepIlxcHeQPdE1WZsFv0sDnb)

    Step2 刪除下方紅色框框的資料

    ![](https://lh5.googleusercontent.com/uoJTMMG1L2Lgz76Zvf7VXgkqIkh97EuaJ5v7joR8s7fQh6QXMj3PcVqzkTHVtjpir82SFfRDrDJyTgy5zXY3ecXjl39D2zkc-TcnQ3d64jnYmpDOcdqeTNcjnyNzF7kC0eRd101D)

    Step3 用binlog回復這筆資料，檢查是否有正確回復

    mysqlbinlog --start-datetime="2017-08-17 17:53:00" \\

    \--stop-datetime="2017-08-17 17:54:00" \\

    /var/lib/mysql/mysql-bin.\* | mysql -u root

    結論:

    資料會正確回復，並同步到別台機器。

    參考資料:[https://goo.gl/vRckLh](https://goo.gl/vRckLh)

    

1. 使用GCP LB串連Percona Cluster

    Step1 建立一個TCP Load balancing ，將percona的機器加入Backends

    ![](https://lh5.googleusercontent.com/EuL2jQMdHEy0-rajFVSESIRNJiqZRNykUMll15Nzt2ZXllrhAYWcDlJKhKH2NLTy1qhkYLN_CV7FgRMKAM2cQ2pENUZMt9x2ThecKHeJKpr0S1Z8_35rpVKAtacjulzVXUwgj0HN)

    Frontend開放3306port

    ![](https://lh4.googleusercontent.com/-YC5lY76qUkwrYeP3Y4TRS3SNknTpvQ8rYWHzai6ra5kGyqmNjvYxHE4YRdstuD_8nIu6SA8j7nQfTWRHJiXW0v06tihmkog-vQuYklwrMhCZ0vkY9TeKV5wF8iSWGwFKg5yfibc)

    Step2  用load banlancer的IP與percona的帳號密碼測試連線，結果是成功的。

    ![](https://lh3.googleusercontent.com/kLWpQCADNt5zORSFgOmRBEDHDN2kNV8kcVcjcnJ_ksd_yJwGJE0qCdTeNk9LFwYWwFnUKN4_-eWqgf1c85NcV3O5XLuJ3jrhY2MmPA8fDgV8bsAOv_kQ97p57zAVjoPk75lg-u__)

    

    總上所述，Cloud Launcher可以快速的協助我們建立Percona Cluster服務，該Cluster提供了我們方便的集群操作與使用(每台主機都可以負責讀、寫)...  至於效能，則讓我們之後測試再分享咯！