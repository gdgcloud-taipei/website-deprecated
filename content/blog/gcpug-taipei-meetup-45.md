---
title: "GDGCloud Taipei Meetup #45 Recap"
date: 2019-03-22T01:59:45Z
draft: false
banner: "https://lh3.googleusercontent.com/VFDtigVoypq63zGaSVXbh-RbKhv5QGxquWDpJq4HAHGy6jgSqsEdBGIEX9JIrIaHgOdkalbStIMygqgHaGIOmK9CVGXbBQ39FU8sMhDuxO7WsJ5gDZdgoFNxmMeuf2DRNb9Dh9hof7uhSRUpAQde8MRv9rvSmHgHwzKW5WAUmWzyYXOIfwfBb1wV9PySHV65FOSCkU0No6gBbIY5x0JZcqzmlooTUWKAznmPQVzLmoa9q0k7iukQJETtrtbvBn-ROgpvtmSpiepvS7GAzCK7M90XJ5weU8Rej4B01ljvrV0irL1YSZJTFc_yGms8RJf_MyRVLHR_ukhdGV1WJFOdptIftN1pbxtPOZogRVByLlxwRz65sf_CQry05XS6DYlthjCRU-UafKecXpkNebg4sYb61LRkm6D-67mfSIapMQV0IRRhj_iS1NeUpALVmLaC33to91wiocrXP7jhnPfRKh9GKIE3QChVTe_MvsmhScIEkjVZKL1tEpogLqV1-aUOEtcIg75gvpsd6b2wIOe8ET3A6vEcXOyGIpLHCde3KNiPCv0AamBsbRDvXOcYLp76rlX0g77B3EYSzcPGhccYrfIuqFyXtuaA8T_4FoDEgYcSKN1TYFtaj9sk7r9ldXsO3dEXI6YJvJKbWHej7FfnDZkWsmu-H_z3qDbVlp2qCArUzwc5wuOUr3AZD_ZdKDz32wixr4e4lfrgFo9lzkjB2vMfSA=w1000-no-tmp.jpg"
author: "Cage Chung"
authorlink: "https://kaichu.io"
translator: ""
translatorlink: ""
reviewer: ["Cage Chung"]
reviewerlink: ["https://kaichu.io"]
originallink: ""
summary: "從 google cloud log 看雲端資料搜集與應用，帶大家從入門到進階，讓你在雲端管理你的資料！ / 從設計架構到實現方式，帶大家進入高效模型訓練。"
tags: ["GDGCloud Taipei", "gcp", "google cloud logs", "ai", "tensorflow", "keras", "meetup"]
categories: ["meetup"]
keywords: ["GDGCloud Taipei", "gcp", "google cloud logs", "ai", "tensorflow", "keras"]
---

時間: 2019年3月20日

地點: Google Taipei 101 Office 77F

講師與 Topic：

- 淺談 Google Cloud Log / Simon Su, Memmie Chang (Ayla DevOps girl)
- 使用 Keras, Tensorflow 進行分散式訓練初探 / Jiankai


### Google Cloud Study Jam (Kubernetes)
> 這一次活動的 Bounces. 參加活動的朋友拿到一個月的 Study Jam(kubernetes) redeem code (沒有拿到的朋友不用擔心，GCPUG Taipie 會再式舉辦 Study Jam)

![](https://lh3.googleusercontent.com/UIbhiM58uYUZUPlRZJkEt6H1u5OZN5qyFRBQ2-bqMGY9PHxE5_Lw0awKZBp8M-Wx0jSR-9wx_asAwKAS3pkiM6VzdFp6dbJlfqWdQfTBbYL0XyTJ7doW8j5FgOeZcDuCSdhVGSBDawlosL27-NYyI93GDf4cSTp1qYoNwqa4detit9490hIcGBBDoBvCJxQ74E4ocnrOk4oftiPDbLGuatu03Og_zFgZMlxWP68OlmRK51h-Nsf3MiLb0c6P-et8x0EN9WHwUC9eqedtDj8wq2nfj0brbR0zNN0cD96nz06IVEp21pglSJwfbyrXEzMkm3n6DtTqiks4ztj4HES44hnmyFg79uO76WMrcDrE505c-ndnlg_tNi4cRvpnZYYX7X-u2JCOHWUjaQbaI_iYk1qxWDJ-T5CIoxc6kDWJ3qdtv2Sz3Oj3fKkUvaRtLnNuWfuJ74wOGpmreKRzyw-J7JaarBCJrgx3hTRH-_di_a4e4ud-FkI9r0ZJwXILC17feG_-KMsuwfG-bAVi5VEVoqHcjw0l_i4p_76fgcTT1x-tFzbLVN2zOjoGiyB8iRT_XMzELYJ5HJfruZJlUNQv__lF3wX0gfQqtNG40ZUD7EwUK52jEmaNZKCukVgr0UvGkrWvCPja0Xo4ToBiIa6SeMMrZhqY-p2f4Ipwbio5fAX1034tjw8UkI4ykwn3qqk_DyNuveoc4-bA1LlQu0kPnfMELg=w1000-no-tmp.jpg)

Meetup 開始前 Eric 說明了什麼是 Cloud Study Jam、如何 redeem。點 [Cloud Study Jam 啟用 Qwiklabs 步驟](https://bit.ly/csj-guide-zh) 觀看詳細

> Google 提供一種線上的 Cloud Training 平台(Qwiklabs)。 Qwiklabs 依照分類 (Catalog) 提供不用的課程(QUEST, GCP Essentials, Kubernetes in the Google Cloud etc.)，每一備 QUEST 都有完整的教程/需達成的目標及有虛擬的 gcp 專案可以操作，還有紀錄追踨

### 淺談 Google Cloud Log

> 淺談 Google Cloud Log / Simon Su, Memmie Chang

![](https://lh3.googleusercontent.com/h9yZfMDW4HkfFRLRJaLQ2doZVVcigv_9oXSBiTnDdmwFENesrfSckM94PzWpyVMajyFNB7WVAhGmNLnCH6O8xuy_L6oVl_yHQnjMV205PWkxpLSiTKZ-YpbqqAGGg2eRiVUCstD27LYLadItKmNDNqDCjkevEtvEK57qVxZ6sdUtmcIaXRUkR9tSELgr5z1lGjOSxKLDqnQeBcPpUizyWpbU4eCBoUjphQ-VITdjNxZDrh_6wqJALQZJpbGBqd4pmJwnkW49WziLNqZ1Hl87faAGXqcGVxgmZ0fn-HSeOHIoZxOQL52sNuYNMnNzmFz1kMlZWTEgDt20WVb_Cnkx9d4JbM8NPUD9ILo3hPgzkH6CGMIeETTYlYtOe5VWFnXL8V-A64VsZU_JnZKU0M8c_DAS281FCiBQoPKvWgyQVJ8ZNdlUFWJGI_YnBdiOP1psejAXjERvdQGE91e2wqA3I2mmUCcqMvYMkdj6fhPOli4-Gid5JmXy6aAzOO9DByhQspw26iNdC4FX5b39zQcBRSDQgLVRq7pL2q7bIa0WAQFedxelfEHEzZg4ZOeLXFC9_zOuvdmDte22jATyvkWQcjRyOr9cgbMjGFGmMgyzgU4sBpXtDXDCchtw3ksgphYxmUx71pqqV8JEoNAiUEJL_oEnovxvckrl4Nps0byr6FYr8PPqtyCoIjD4McontZlHh5eoTpeuKI5FjQfbxsEPGAySHw=w1000-no-tmp.jpg)

**Simon** 正在說明 Google Cloud log 的使用情境。Google Cloud 上的服務很多都已經跟 Cloud log 作整合了，使用上非常方便

- GAE 內建就已經將 log 送至 Cloud log
- GCE 上可以透過 fluentd 將 log 送至 Cloud log
- Cloud log 可以將 log 送至 BigQuery 進行分析
- Cloud log 可以將 log 送至 Datastore 儲存
- ...

![](https://lh3.googleusercontent.com/VFDtigVoypq63zGaSVXbh-RbKhv5QGxquWDpJq4HAHGy6jgSqsEdBGIEX9JIrIaHgOdkalbStIMygqgHaGIOmK9CVGXbBQ39FU8sMhDuxO7WsJ5gDZdgoFNxmMeuf2DRNb9Dh9hof7uhSRUpAQde8MRv9rvSmHgHwzKW5WAUmWzyYXOIfwfBb1wV9PySHV65FOSCkU0No6gBbIY5x0JZcqzmlooTUWKAznmPQVzLmoa9q0k7iukQJETtrtbvBn-ROgpvtmSpiepvS7GAzCK7M90XJ5weU8Rej4B01ljvrV0irL1YSZJTFc_yGms8RJf_MyRVLHR_ukhdGV1WJFOdptIftN1pbxtPOZogRVByLlxwRz65sf_CQry05XS6DYlthjCRU-UafKecXpkNebg4sYb61LRkm6D-67mfSIapMQV0IRRhj_iS1NeUpALVmLaC33to91wiocrXP7jhnPfRKh9GKIE3QChVTe_MvsmhScIEkjVZKL1tEpogLqV1-aUOEtcIg75gvpsd6b2wIOe8ET3A6vEcXOyGIpLHCde3KNiPCv0AamBsbRDvXOcYLp76rlX0g77B3EYSzcPGhccYrfIuqFyXtuaA8T_4FoDEgYcSKN1TYFtaj9sk7r9ldXsO3dEXI6YJvJKbWHej7FfnDZkWsmu-H_z3qDbVlp2qCArUzwc5wuOUr3AZD_ZdKDz32wixr4e4lfrgFo9lzkjB2vMfSA=w1000-no-tmp.jpg)

**Memmie Chang** (Ayla DevOps girl) 在說明收集 log 的架構。如何收集 k8s node/pod/master 上的 log 至後面處理 log 分析 (kafaka + ELK, Elasticsearch, Logstash, Kibana)

### 使用 Keras, Tensorflow 進行分散式訓練初探

- [使用 Keras, Tensorflow 進行分散式訓練初探 - Google Slides](https://docs.google.com/presentation/d/1I96h-rzGsVYx4A_hZF_sZbsi47SiRyOiR_Et90uHO4Q/edit#slide=id.p)
- [jiankaiwang/distributed_training: This repository is a tutorial targeting how to train a deep neural network model in a higher efficient way. In this repository, we focus on two main frameworks that are Keras and Tensorflow.](https://github.com/jiankaiwang/distributed_training)

![](https://lh3.googleusercontent.com/TJVWVAe7xQA0KqjJigJndyPfm5zSrALPmeb_dymVe2viFII7vSTUnHnnNB6o4mk4-liTMxy4nPn2je3zjnUqKCtsARNsqh_ekV7aEg6ElwUhtZJCyDN_3_Q2w2I4S8vf4GDgHqpukL-N4rb3zh-i6fPdH74Y9XpKuw7ifW9gzRMRNAbcpbcknTm6dsdnSkTrqoD93FJ1NwJd5zUcZbjYeccxhac3751OIfFVW65NSBZHIoZzcKqVCcDEkRlkpnUt8NIdfo47hk_7WxMBhxMgCsSFJelw5a-_kUPlDY_DgykdQLIjXoQbHVQ8J0qH8sTkH5frkKMxWW70Q90WqhuzUkByUbaKwgE8JB4as_f5LsxhFZ1JBb4pT8w7kKDMqm_pUNdwwArPEquOgNK4vE1ELfPw-3ziTCj1VnM6EDmSsdIe9EdXF0d7fVym_jJMBP_mRZdF-fY-CQLWWV5vyevGz9odTGIWd0_fvqBeJ_ZXaUicErSYlqyuWEC_-sD_clW1i40my-UjaG6c22Qc6YvtbAYRrU8XS_TW7xejchPQun46BZfSficSOpLgHst0vF6XeJDEqjPYfrZg4ltD2pzbTTIpz-ug6fUeLJp3VR6TlWt9XLRpFc7quvXaY7_sw7GfGEx9t6x-4vnyhA7zE7fCrzJwRx2sx99_PwTgDd7fME3Mnk6WoruHbrgGPlZvHGodpNIXFkRmTAYEaEHj1lvtY6Mdwg=w1000-no-tmp.jpg)

**JianKai** 正在說明現通用型的 AI 開發流程。資料準備與前處理 (含標註) → 資料格式與存取解決方式 → 模型組態、訓練與建立 → 模型組態、訓練與建立 的循環過程當中。當你的 AI 並非主力產品而是加值應用之後，在資源有限的情況下，`了解需求精確命題應用場域反而是最重要的部份`

![](https://lh3.googleusercontent.com/osF0loB1fa98qWRnkWb1e54YT5ulGRMvtqqGEwQ_Gq087_RLVnO_vCiumBQvn-CAiUxTERmZ8cQR9c4e5wiSf2wBZYLs3OUdhqOqBbzpjwbAxrHbggp3Mde4na-wu0YSvWsW8-jVp3KN4Gonmw9QI-Y4ka3WuFbIfAKpF5J09hbyFYA4HVc2pYihUe5kA6_bhoZcuWN8riEALV_ZB1GsQnHIUOJcanplN2l44btKhz3OiYJSFFa3CUjj-GDZuyqJ05xNvjdS0-Jq0Cd4dZG4DdSL1Lheti2YArc7oldahi9H_qbzdSCMqJKaYdZhd_0ts_wIL8ZrPVVnqRUkROX03DclAeCDG3XRJeNOXfdS9ibiF0OE_CtBBOGbks2A-An1-32CQqAn6KXec21MEGv0um3BhsJwNTAnUl1Vlw8wMTuuveaMAqJVUnj4R29l_ebPdRbjCBQqkQglhlcYJy7ZmB4rrR_eolOIcaDud9cS9fIypNn02s_cD2_sHNPXGxwUE7l3K7ycnTrhpQZiA5y11LwUcaLgRY7GfQiv7Ek73wBsqPQSdQBzw7W-ZbjM2ICJdY57eB4YvDhVIn-dwgTYEzmRxLIEhZJLbB3UOuVyUzdoYokKlEStcgbCE9pc_aMjOwZmXvnL6knYqXoXGybvFMQvLfanyRsN96iv3nRBy2QQNkDjGlhyk3Yx2cSNixbxIfXnZjCRN2t99dL0p_6OAJmMQg=w1000-no-tmp.jpg)

#### 活動相簿

[GDGCloud Taipei Meetup #45 - Google Photos](https://photos.google.com/share/AF1QipMrRaI5ficPnqUB99VWeFqHteqJetEbjvpMOZlhgE6C_Rexlswfo4TYUZ9ON4HcYg?key=dzdyQVlnaEFnSkk0WDZqdU4yb1BlQkdUekZhQU5B)