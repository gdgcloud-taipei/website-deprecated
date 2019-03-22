---
title: "資料庫搬到Cloud SQL - 使用AWS  DMS服務"
date: 2017-08-07T03:23:00-07:00
draft: false
banner: "https://lh4.googleusercontent.com/R5MHBADWmfO0rPyKTz83MTZANMYdZVnEfWxf7qBlEAVVhlMyX9aU9pgomTddcnRXLxMFrntmgMVwXx7xLQN3O91M2hmW7ZzPMC-021GV03LPQxBct3CL09So_R2UsO_BpDHjx8uT"
author: "Yi Jhen Hong"
translator: ""
originallink: ""
translatorlink: ""
reviewer:  ["GCPUG.TW"]
reviewerlink:  [""]
authorlink: ""
summary: "Google CloudSQL提供高品質的資料服務，但在使用之前，一般大家會問到該怎麼把資料庫搬到CloudSQL的環境，CloudSQL提供透過 Cloud Storage來做 import/export，如果再資料量不是很大的狀況下，直接針對資料庫做 export 然後存放到 Cloud Storage後，再 import 到 CloudSQL 的速度還滿快的... 但是如果需要做到持續同步資料，則我們會需要一些規劃與工具來持續同步您的資料。"
tags: ["CloudSQL", "storage"]
categories: ["STORAGE"]
keywords: ["CloudSQL", "storage"]
---

Google CloudSQL提供高品質的資料服務，但在使用之前，一般大家會問到該怎麼把資料庫搬到CloudSQL的環境，CloudSQL提供透過 Cloud Storage來做 import/export，如果再資料量不是很大的狀況下，直接針對資料庫做 export 然後存放到 Cloud Storage後，再 import 到 CloudSQL 的速度還滿快的... 但是如果需要做到持續同步資料，則我們會需要一些規劃與工具來持續同步您的資料。

AWS DMS在資料轉移上是一個不錯的選擇，透過簡單的設定流程，可以快速的備份你的資料從一個Database到另一個Database，這裡以MySQL與CloudSQL為例，給大家參考：
  
建立步驟如下:

Step1 建立Replication Instances

![](https://lh4.googleusercontent.com/R5MHBADWmfO0rPyKTz83MTZANMYdZVnEfWxf7qBlEAVVhlMyX9aU9pgomTddcnRXLxMFrntmgMVwXx7xLQN3O91M2hmW7ZzPMC-021GV03LPQxBct3CL09So_R2UsO_BpDHjx8uT)


Step2 Replication Instances建好之後會給一組IP address，將這組IP加入你的DB network DMS:   

![](https://lh5.googleusercontent.com/SckqjaYf3OBXrdY9yffF-1N-ZMAX2PDo8wF2jIACIhZMYhm_90tLqgkEZLXSaGBS62Ng_MpGIVmrSfgG10OO8ncIwr5GFdsThpXGUoBroErttXIUV4kNb4K3sgvobeB7Gd0inLAQ)


另外，GCE需要加入DMS的IP:

![](https://lh6.googleusercontent.com/lLrlSsSHSHVbQQgQFOTvrg_xUaIFAbUdhclS77_8w-yGuLhYtKEqKXKuIqOS5-h_bMx1GFnVQHHQvFOCqRcyj9QIx3GKydUUVyYpS4qSOJX6rlkTEGV7YPg28fwbQy-VZpfnwaey)


Cloud SQL 加入DMS的IP:

![](https://lh5.googleusercontent.com/TOM_lxpCfFg7k7mCeuaPN_qLfKporREEeen95hZ-4xe0igaAWne3kg5zujEea8vP1kscjDwpHp_GQ_fIKQQ_iHMYF1wFKrsU_f3PbS5pgO5FhEVfGpVBoTZ0NMrNplWcBtx8emkA)


Step3 建立source、target的Endpoints

![](https://lh3.googleusercontent.com/u-kGe_Q2284J1q7-a1dfKBoXjKG7ZzQeMjEwukKGcsA-ZEVEfD2Rp0xXBztAEELsV5L9baKQLi3tgGVUJ7p80wJ0dkN0mMIYdkRUvjaGNRTjoh-ac0agIE84pZfZcMCVyA0RBFeZ)

  

Step 4 建立Tasks

指定從哪一個source到哪一個target，要migrate哪個database哪些table。

![](https://lh4.googleusercontent.com/IypIr8b5s_NDdTvOa8q5DjrPuvn6wb4TeerdnTb_OPl4MVGjp_Jnf2Ym93cvopUsmvgo4HDtmRNi6lH1QdCk6217aOse1q-HXMKA1Y2yEiGkfqeIk1UKxElPeSDkg4wTVbDORHQ1)


建立完成後，若沒有錯誤資料就會開始備份...

情境測試:

1.測試Table內有特殊設定的欄位

*   有sequence的Table
    

結果: 轉到Cloud sql上，設定會不見，要再自己加入

![](https://lh5.googleusercontent.com/4oLuCxBK7_2jsIH7Wrvi7R3RfCFPoS7e69ff0WxpT0UrPk9v22zd6vGY2y19ex1HNvaYZsKZQuwiT6xho8QoqcxzT4Tm1TlN6IHpbcSJzKVQhuGZajHbF9le32XkT51g4CqnrI2G)

  

*   有fk的Table
    

結果: 轉到Cloud sql上，設定會不見，要再自己加入

![](https://lh4.googleusercontent.com/fM2JJpFLQuVcqg0V0XDEXMzDHBhPVaBIUdGaDrPMEVb-4KZ_VlJMiKGKFXFfBuOIQ0QTaxEnXSZ9ER7uRjXFs9VsvI2f7ZN623MMVONAC4lOmRsS2czMRRzZfiNhJ4xNY4VVHFva)

*   有timestamp的Table
    

結果: 轉到Cloud sql上，設定會不見，要再自己加入

![](https://lh5.googleusercontent.com/R-pFMy0jGamhRSBgvImReV_jpOrq2ydVqJNS2g53P72AcBrRkbdKJ8D093hpw4ZM0hLhVwXuyNKvY5vTtTHEw-rRSqbsuXzSGDZD7GCB6siLbvnjpNY4C_p4Ufyqy01rrEsq_Epn)

2.轉10000筆& 100000筆的時間差?

  如果是直接從DMS上做Migrate existing data，5分鐘內資料就會sync到目的端；若是用Replicate data changes only，一筆一筆sync時間就會拉的比較長。

  

3.當schema相同，加入異動資料時會有什麼情況?

*   Migration type：Migrate existing data > 做一次性的sync
    

1.  Target table preparation mode：Do nothing
    

![](https://lh5.googleusercontent.com/eQjk2cIUP_yYAk7nfcNb5w454UZWpMor3JiVLH_DoGWwkJVOk8Ezd-0x1L3hcBrM9eqm0XecSdJzwEqczw8xc_XcumoS84ll9kbr0n6rJlXb82NUpz4BurhfTJMCSnHtLcG8iODl)

  結果: 若已有相同的pk的資料存在，那筆資料不會異動，會加入目的端沒有的資料。

2.  Target table preparation mode：Drop tables on target
    

![](https://lh4.googleusercontent.com/JvM8cq5OewdlaJduqlON1SExyOXtquRBtQyJOhIth_ifBhg_hdsWTptlMHggBAQ7wbbE__F55ODZhcIkGE2ATHvlcDwpktT6FMW0Uf2H2e49cTNx2h_--hWWM-IqwA-OFd8cnQah)

結果:目的端若已存在相同名字的Table，Table會重建，資料會被覆蓋。

  

3.  Target table preparation mode：Truncate
    

![](https://lh4.googleusercontent.com/Ef9ognQkACgNZeAY82CJ2n90dgHnV4jvFgrV5HcoVQnwPkro9tTZvBl7IEiTWQGz2OPKEFQFHISbwKQ-mRU0Lb9ZdhUV3AbwZkxdtsb8Z4-qCEwguaw7hEftBPtTiipkF4QVc8rk)

結果:目的端若已存在相同名字的Table，Table不會重建，資料會被覆蓋。

*   Migration type：Migrate existing data and replicate ongoing changes >第一次會做資料sync並持續針測資料是否有異動
    

1.  Target table preparation mode：Do nothing  
    

![](https://lh5.googleusercontent.com/BN4n-e5N-a4E2pd35vzbO4_K4vE3w9QjkFMIAKUHLTeJvGKzlZpj5FNebuRQ95H47SSBlYbbplRLICYVHFScgP4PhvTIsPJvCF3rVEuaB1XSd15joPGpleIhVISKrDQFR5oQcHMr)

結果:

     目的端原有的資料不會改變，會加入目的端沒有的資料。當來源端有資料新增、修改時，目的端會同步。

  

2.  Target table preparation mode：Drop tables on target
    

![](https://lh5.googleusercontent.com/NEpbiA6VoXWpUqQMPALEh0N7qSogBxc_v_0dsVQnumZddnMG9Dqpt0CapOjbyi-z_hy6iBnrxi5zfPKQ3bEIWgndBIrqojc7j8Ylgr8HXNZO5seEKhB5lLzZeS6Yij63mP8hhLj_)

結果:

     目的端的Table會被重建，資料被覆蓋。當來源端有資料新增、修改時，目的端會同步。

3.  Target table preparation mode：Drop tables on target
    

![](https://lh3.googleusercontent.com/QZv6Hf0KuWCRVRx0VqSQj6sfX7jtlOBHkxJ4KJpp1wHDxTHB7KRTemd66sua35e-EfQmgt0D_ICqw-wXbu_OlKLx5tNcMJ4NHTe8u0vOlSVelN4h3DZD_lKPNNRcz4SiMhmo6jQh)

    結果:

       資料會整個被覆蓋，但Table不會重新建置。當來源端有資料新增、修改時，目的端會同步。

*   Migration type：Replicate data changes only > 只會針測資料是否有異動
    

1.  Target table preparation mode：不論選哪一個
    

![](https://lh3.googleusercontent.com/f73rX3Uy-6Gp1PlCaQjhwFPeYCjihUfFT6KdiHhSCJsGpUkJLO0cjeWlpT4Fsre6go2VXxK35iqnYSZ8gOStAI_bziZDg4wlHcBdHeBUMGoYNSwS0aKH70OOKyrxXzLuhv0Dr1Q2)

    結果:原有的資料不會被覆蓋，table也不會被重新建置，當Table的資料有異動的時候，才會同步資料。

PS：要做異動資料的同步前，要在source那台的mysql設定這些參數

[http://docs.aws.amazon.com/dms/latest/userguide/CHAP\_Source.MySQL.html#CHAP\_Source.MySQL.Security](http://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.MySQL.html#CHAP_Source.MySQL.Security)

![](https://lh4.googleusercontent.com/SwGnYU_gTQFGs_QAm3ld5Adb9uAvkbQ9x9bBbK1FmHcM59hebmkaUKQScuJaaPocj0uEurU-se-igOED876fRPXBO6SpnOKTzZD3hMRBbqmzll2FT1ydYalMJmLms9E6A0zc5Zls)