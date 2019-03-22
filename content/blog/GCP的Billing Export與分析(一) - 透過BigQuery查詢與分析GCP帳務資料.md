---
title: "GCP的Billing Export與分析(一) - 透過BigQuery查詢與分析GCP帳務資料"
date: 2017-07-01T02:24:00-07:00
draft: false
banner: "https://lh3.googleusercontent.com/BY5yF3cTJkmW9ENWQ7Zk9x936YX96hUuj2XS3jyj-Byofg-00GPcN1rwlSAVKvzSVU7dmRJtQsdMb7fnLfzv3hQitfgHxTHaTopKaBbVchfW4VH7k4DJtQ2ZWBxHbRvleGokiofh"
author: "宜禎"
translator: ""
originallink: ""
translatorlink: ""
reviewer:  ["GCPUG.TW"]
reviewerlink:  [""]
authorlink: ""
summary: "GCP提供雲端服務平台之相關產品，在計價上，GCP提供Billing檔案的匯出，從GCP web console設定，可匯出至BigQuery、Cloud Storage與PubSub幾個目的儲存體，本次跟大家介紹BigQuery的匯出部分，並藉由BigQuery的查詢呈現您想要的報表。"
tags: ["BigQuery", "billding", "PubSub"]
categories: ["BIG DATA"]
keywords: ["BigQuery", "billding", "PubSub"]
---

GCP提供雲端服務平台之相關產品，在計價上，GCP提供Billing檔案的匯出，從GCP web console設定，可匯出至BigQuery、Cloud Storage與PubSub幾個目的儲存體，本次跟大家介紹BigQuery的匯出部分，並藉由BigQuery的查詢呈現您想要的報表。

GCP Billing export to Bigquery
==============================

在您的Billing Account的設定頁面中，可以透過下面的介紹設定好Billing Data的匯出動作...

  

首先，進入Google Cloud Billing頁面後，可以在BigQuery export的項目中設定匯出Billing資料至某個您具備權限的project下的BigQuery dataset中...

  

![](https://lh3.googleusercontent.com/BY5yF3cTJkmW9ENWQ7Zk9x936YX96hUuj2XS3jyj-Byofg-00GPcN1rwlSAVKvzSVU7dmRJtQsdMb7fnLfzv3hQitfgHxTHaTopKaBbVchfW4VH7k4DJtQ2ZWBxHbRvleGokiofh)

  

設定完成後，BigQuery就會多一個dataset並且自動產生一個table，該table的名稱規則為：gcp\_billing\_export\_$billing\_account\_id

  

![](https://lh6.googleusercontent.com/2kF2HWwq44X_pVjGrd2n5Za1iNDvbBfpcLBjt0vcwvOgXe5z9pE6P8C41ypYSqi8V-3rCh1R7fkVImDqrcKIcMdjqZ40Cvn30LCXpKfIknQCmawlsoOF8us_pQq8hYQiZZoWZ5N8)

  

原則上設定完後，Billing的資料會等約2個工作天才會完整的進來，如果沒看到全部的資料，請不要擔心＾＾

建立報表
====

下面是透過BigQuery來取得某個期間的每日各項目加總(日期自行修改)的查詢語句。結合上述的專案帳務資料的匯出，可以得到所指定日期內每一天的所有項目費用紀錄，可以讓您方便了解每項資源在每天的使用上，在各專案中的比重約為多少...

  

SQL:
```sql
SELECT t0.product ,strftime_utc_usec(t0.start_time,'%Y%m%d') as  date ,  
round(SUM(t0.cost),6) AS cost_total  
FROM (SELECT * FROM [your-project-id:daily_billing.gcp_billing_export_$billing_account_id]  
WHERE _PARTITIONTIME >= TIMESTAMP('20170401')  
AND _PARTITIONTIME <= TIMESTAMP('20170620')  
) AS t0  
GROUP  EACH  BY t0.product,date  
ORDER  BY  date,cost_total DESC,t0.product;
```
  

查詢結果如下：

![](https://lh5.googleusercontent.com/tT1KQZucfc8pcP_KGzofOSlr1eym_ms7y8oWJRBdmXbJiwGFFnlHqabmY-3Afq3tZIwfplqltG_bX8S0CfuQoP2BOfBvYnZoQxJBAU_jiblx9DUb0Up8DV2LF2yzYsHXP0W0ruJz)

  

上面以日為觀察區間，我們也可以使用月為區間觀察，透過下面的SQL可以了解每個產品的用量，佔本月的比重(日期自行修改)

  

SQL:
```sql
SELECT t0.product ,round(SUM(t0.cost),6) AS cost_total  
FROM (SELECT * FROM [your-project-id:daily_billing.gcp_billing_export_$billing_account_id]  
WHERE _PARTITIONTIME >= TIMESTAMP('20170206')  
AND _PARTITIONTIME <= TIMESTAMP('20170511')  
) AS t0  
GROUP  EACH  BY t0.product  
ORDER  BY cost_total DESC,t0.product;
```
  

查詢結果如下：

![](https://lh5.googleusercontent.com/cYbgfD8Nnbnmt4o1XWo75LSwL7np4c47mngYevEaG_pFG_SKyYAjhUhyv61g7nQ6GFySyNqsQtyNEUlPVPWOO5z6br667kRjQIEClesqCyqCSseAIlG5xX5t8w1PiG4DlyC2zuFt)

  

進一步，我們想透過往前推三個月各個月的金額加總(日期自行修改)做比較，可以使用下面的SQL來做分析...

  

SQL:
```sql
SELECT t0.product,strftime_utc_usec(t0.start_time,'%Y%m') as  date,  
round(SUM(t0.cost),6) AS cost_total  
FROM (SELECT * FROM [your-project-id:daily_billing.gcp_billing_export_$billing_account_id]  
WHERE _PARTITIONTIME >= TIMESTAMP('20170401')  
AND _PARTITIONTIME <= TIMESTAMP('20170630')  
and project.id =$project_id  
) AS t0  
GROUP  EACH  BY t0.product,date  
ORDER  BY  date,t0.product,cost_total DESC;
```
  
查詢結果如下：  

![](https://lh4.googleusercontent.com/kUVgPjeBEoDC0qxmw519gDWYaR5N2YuwvZaQF8cGAAhpRuB3VEBq-CPVm26JIGy0ktc7R8XBV_uE6oV4gzpSEMCgRpisQ5lq01oBUDDmML30sfJmv07gFWVhUh_mN20ZF1aiwI4m)

  

最後，如果想了解您每個project每個月的花費(日期自行修改)，可以透過下面的SQL來查詢...

  

SQL:

```sql
SELECT strftime_utc_usec(t0.start_time,'%Y%m') as  date,t0.project.id,  
round(SUM(t0.cost),6) AS cost_total  
FROM (SELECT * FROM [your-project-id:daily_billing.gcp_billing_export_$billing_account_id]  
WHERE _PARTITIONTIME >= TIMESTAMP('20170201')  
AND _PARTITIONTIME <= TIMESTAMP('20170630')  
and billing_account_id =$billing_account_id  
) AS t0  
GROUP  EACH  BY  date,t0.project.id  
ORDER  BY  date,t0.project.id;
```
  

查詢結果如下：

![](https://lh4.googleusercontent.com/v6bW98j6YooB5WoomMrMctybcIjJCgOARzpgXaJDQt9fu__6gAbzk_UY0sMkRTyiQYZt_81kpuUk52gHQrbEpusgpvXLDQ-obsX4MqSsbUGNHX8Z7AO4BokiZUcJNli1hCoK_pNc)

  


  
--- 

作者：宜禎