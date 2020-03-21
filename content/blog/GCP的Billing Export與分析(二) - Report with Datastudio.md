---
title: "GCP的Billing Export與分析(二) - Report with Datastudio"
date: 2017-07-01T02:33:00-07:00
draft: false
banner: "https://lh6.googleusercontent.com/OsYXoH_4GzVwiloxSxRceK5gedD164SMc9HWS-xhtdQ-U8xvp1gPRKa2WTtIGrSFWX4iBfHy8RBqfakbn5U6etYGDfQ48hv4I4z0fO57HQuz8f7lrikK7KIzJrMv-FmsAWNNGZCR"
author: "宜禎"
translator: ""
originallink: ""
translatorlink: ""
reviewer:  ["GDGCloud Taipei"]
reviewerlink:  [""]
authorlink: ""
summary: "Datastudio是Google所提供的線上報表工具，可以透過簡單的定義data source來撈取多種的data格式，甚至data的來源，當然，其上支援Google的大數據資料來源，包含BigQuery, Sheet, Cloud Storage, Cloud SQL等等... 加上前篇所介紹，透過Billing Export來匯出帳務資料，我們可以結合這篇所介紹的功能來製作各種報表..."
tags: ["BigQuery", "billding", "Datastudio"]
categories: ["BIG DATA"]
keywords: ["BigQuery", "billding", "Datastudio"]
---

Datastudio是Google所提供的線上報表工具，可以透過簡單的定義data source來撈取多種的data格式，甚至data的來源，當然，其上支援Google的大數據資料來源，包含BigQuery, Sheet, Cloud Storage, Cloud SQL等等... 加上前篇所介紹，透過Billing Export來匯出帳務資料，我們可以結合這篇所介紹的功能來製作各種報表...

  

Step1 至Google Datastudio ([https://www.google.com/analytics/data-studio/](https://www.google.com/analytics/data-studio/))，點選sign up for free，用google的帳號即可登入。

  

![](https://lh6.googleusercontent.com/MpwHkTnbpFVb5h_dYfqvn9qbXLzeVPqgAjBRbny7GjBgO1pFJJDfKwiOU1U0VZlG92UhlElH9UupW-HXCxcrlpcBtPEynL1Wv5FuoChgQuBX24NvXm_9p_57Wi72qQpPOAG0K6sx)

  

Step2 將BigQuery的資料設置為datastudio的資料來源。點選”資料來源” 並按下右下角的加號

![](https://lh5.googleusercontent.com/FIewp-wRXLwI1KuX1ivDlxwP6WT8NwwfeK5jGAUbnzm35hC-9dvCWU-S6y9FL8lKdg9GMfeEyPbaoVzZXzixY_6Ondw6Xx-DPcBJW7wQig_gffmduyHYQkhwUz6Bw5_Rv6P3dUdA)  

選擇BigQuery > 你的專案 > dataset > table，最後按下右上角的連結，Bigquery的資料就可以在datastudio中使用。

![](https://lh6.googleusercontent.com/OsYXoH_4GzVwiloxSxRceK5gedD164SMc9HWS-xhtdQ-U8xvp1gPRKa2WTtIGrSFWX4iBfHy8RBqfakbn5U6etYGDfQ48hv4I4z0fO57HQuz8f7lrikK7KIzJrMv-FmsAWNNGZCR)

  

Step3 建立報表。點選建立新報表後，旁邊的資料來源就多了你剛剛新增的GCP Billing，點選並將這個資料來源加入此報表。

![](https://lh3.googleusercontent.com/QnhiFptyOQQaf4wWvRvlFcCGIK5XGjlrZRwucm3tsfdQ1i3jeGeG2itSWkDIfzSGwqHkoMzBQqA4pbsd9nwCs807SLlLsq-2nb7VfzHp_QRPu4aBodbak3JWXjjR5ucgaPFK7rob)

點選圖建立報表，如下圖

![](https://lh6.googleusercontent.com/SkUcZsx9BeKxPJLO0khB4QrO1nDETtTR5S3EN7PYy2_CYBS7E7M-qlSR9Mtj6BxkA48TlcdlbXIf94Q1MnYaxdJSLZxCyexi0Mm6_fVowOyLX8S80O5oyKzNHvZ96j9iXQLzDD_A)

  

簡單的介紹到這邊，接下來需要大家努力把SQL結合進來咯，下面是一部分報表的完成品，給大家參考一下.... 這邊透過加入日期filter的功能來設定報表的區間，可以讓您的報表更具備彈性喲！

  

![](https://lh5.googleusercontent.com/xvMs0RoPCCOLkmOvUCynuYhDYTtXL8_tPEOMhNmerqhKJPwp4khQvdHwch3pSzLiUHc1vGTE75g0Fl549ihPgQnRtylIBfnvIO1uZ_p1ZRaJPYnhviArkh95H3f_iVmj07l_F_hn)

  
---

作者：宜禎