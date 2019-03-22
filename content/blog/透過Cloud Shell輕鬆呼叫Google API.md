---
title: "透過Cloud Shell輕鬆呼叫Google API"
date: 2017-05-27T06:30:00-07:00
draft: false
banner: "http://2.bp.blogspot.com/-JGQyYYchuYs/WSl_lh2QmSI/AAAAAAAAAuY/qzAKrCaIh2EheTJVZ0k5iobcPxisG4BoQCK4B/s320/image-762039.png"
author: "GCPUG TW"
translator: ""
originallink: ""
translatorlink: ""
reviewer:  ["GCPUG.TW"]
reviewerlink:  [""]
authorlink: ""
summary: "我們知道Google有提供API Explore的工具，讓所有Google的API都可以快速的在API Explore上瀏覽API的呼叫與結果，讓開發上非常方便.... 下面介紹透過Google的Cloud SDK工具來進行API的呼叫作業... 話說，懶得安裝的話，可以直接使用Cloud Shell喲～"
tags: ["Cloud Shell", "API", "SDK"]
categories: ["Cloud Shell"]
keywords: ["Cloud Shell", "API", "SDK"]
---

我們知道Google有提供API Explore的工具，讓所有Google的API都可以快速的在API Explore上瀏覽API的呼叫與結果，讓開發上非常方便.... 下面介紹透過Google的Cloud SDK工具來進行API的呼叫作業... 話說，懶得安裝的話，可以直接使用Cloud Shell喲～

  
透過安裝的話，通常透過下面幾個動作即可完成安裝與認證...

  

安裝Google Cloud SDK…

```shell
curl [https://sdk.cloud.google.com](https://sdk.cloud.google.com) | bash
```

認證 Cloud SDK…

```shell
gcloud auth login
```

幫Google的SDK工具設定application default login...

```shell
gcloud auth application-default login
```
  
如果跟我一樣懶得安裝，可以透過Cloud SDK... 首先，開啟Cloud Shell，進入可以執行的畫面...  


[![](http://3.bp.blogspot.com/-WEz-9TFGYIo/WSl_lXHGMdI/AAAAAAAAAuQ/TKg6KZSBaVw0Io_hHB2IkvL9z_TwLPOjACK4B/s320/image-761290.png)](http://3.bp.blogspot.com/-WEz-9TFGYIo/WSl_lXHGMdI/AAAAAAAAAuQ/TKg6KZSBaVw0Io_hHB2IkvL9z_TwLPOjACK4B/s1600/image-761290.png)  

  

在Cloud Shell中，由於內建所安裝的Cloud SDK已經載入了使用者的權限，因此可以方便的呼叫相關的SDK與取得Token...

  

[![](http://2.bp.blogspot.com/-JGQyYYchuYs/WSl_lh2QmSI/AAAAAAAAAuY/qzAKrCaIh2EheTJVZ0k5iobcPxisG4BoQCK4B/s320/image-762039.png)](http://2.bp.blogspot.com/-JGQyYYchuYs/WSl_lh2QmSI/AAAAAAAAAuY/qzAKrCaIh2EheTJVZ0k5iobcPxisG4BoQCK4B/s1600/image-762039.png)  

  

取得 access token…

gcloud auth application-default print-access-token

接著，我們可以選定一個所要呼叫的Google API進行呼叫 ….，這邊以Google BigQuery為例，可以呼叫 /bigquery/v2/projects/:projectid/datasets 來取得API的結果... 呼叫的內容中，需要在Header處加上Authorization的Bearer token，即是上面取得的access token...

```shell
$ curl -H "Authorization:Bearer `gcloud auth application-default print-access-token`" https://[www.googleapis.com/bigquery/v2/projects/mitac-simonsu-2017/datasets](http://www.googleapis.com/bigquery/v2/projects/mitac-simonsu-2017/datasets)  
  
{  
"kind": "bigquery#datasetList",  
"etag": "a19Ag3pFAfODmeUgLyZLAGQkEbw/cPgw99f5WxGc2E7mmb4m4gpsjqg",  
"datasets": [  
 {  
"kind": "bigquery#dataset",  
"id": "mitac-simonsu-2017:demo",  
"datasetReference": {  
"datasetId": "demo",  
"projectId": "mitac-simonsu-2017"  
  }  
 }  
]  
}
```

以上，如果要測試Google的API，透過這個方式還滿方便的喲＾＾