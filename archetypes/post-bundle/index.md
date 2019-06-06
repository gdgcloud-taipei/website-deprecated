---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: true
banner: "./blog/{{ replace .Name "-" " "}}/images/gcpug-taipei-default-banner.jpg"
# banner: "https://storage.googleapis.com/gcs.gcpug.tw/website/gcpug-taipei-default-banner.jpg"
author: "N/A"
authorlink: ""
translator: "N/A"
translatorlink: ""
reviewer: ["Cage Chung"]
reviewerlink: ["https://kaichu.io"]
originallink: ""
summary: "這裡填寫文章摘要(這兒為可以搜尋到的文字)"
tags: ["gcpug taipei"]
categories: ["gcp"]
keywords: ["gcpug taipei", "gcp"]
---

#### 圖片引用
> 請把圖檔複制到 `./images`, banner 的部份請替換掉想取代的圖片，沒有 banner 請替換 default 的圖片

![](./images/gcpug-taipei-default-banner.jpg)