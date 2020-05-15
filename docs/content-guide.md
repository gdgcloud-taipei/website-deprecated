# 內容管理指南

本站除主頁外的所有內容都是用 `Markdown` 格式文檔編寫，然後由 `Hugo:v53` 渲染出 `HTML` 頁面。所有的 `Markdown` 內容都保存在 `Content` 目錄下。

## 預設模板

建立部落格的預設模版位於 `archetypes/post-bundle/index.md`。

__archetypes/post-bundle/index.md__
```markdown
---
title: {{ replace .Name "-" " " | title }}
date: {{ .Date }}
draft: true
banner: >-
  https://taipei.gdgcloud.tw/img/gdgcloudtaipei-avatar.png
author: null
authorlink: null
translator: null
translatorlink: null
reviewer:
  - Cage Chung
reviewerlink:
  - https://kaichu.io
originallink: null
summary: >-
    這裡填寫文章摘要(這兒為可以搜尋到的文字)
tags:
  - GDGCloud Taipei
categories:
  - gcp
keywords:
  - GDGCloud Taipei
  - gcp

---

#### 圖片引用
> 請把圖檔複制到 `./images`, banner 的部份請替換掉想取代的圖片
```

其中包含部落格文章的一些元数据。

- title：文章標題，中文和英文間**不加空格**，中文的破折號用`—`，即減少一橫
- date：部落格文章創建時間，`make new`命令自動生成，預設最新生成的文章將優先顯示
- draft：是否是草稿，設置為 `false` 才會發佈出去，預設是 `true`
- banner：預設為 gcpug taipie 的 logo，可以引用自己的圖檔作 banner (banner 建議 1000*750 像素)，
- author：文章作者
- authorlink：原文鏈接或者作者的個人鏈接地址
- translator：譯者名字，若為翻譯的文章可以不填
- summary：文章摘要，會在“最新文章”一欄顯示
- tags：標籤，可以寫多個
- categories：分類，可以寫多個，頁面上顯示第一個，一般寫一個就行
- keywords: 關鍵字

注意：頁面右側的“分類”和“標籤“顯示的是所有部落格的，而非當前部落格頁面的”分類“和”標籤“。

## 建立的部落格

如果需要建立新的文章，只需要執行下面的命令：

```shell
$ make
Usage:

  new           Create a new post (ex. make new GDGCloud Taipei meetup 47)
  server        A high performance webserver
  cleandocker   Clean hugo-server docker container

# 建立新的文章
# ex: make new gcpugtaipei new post
$ make new <replace your post title>

# 在本地端啟動 hugo server 進行測試
$ make server
docker run --rm --name hugo-server -v /Users/cagechung/Documents/gdgcloud-taipei/website:/src -p 1313:1313 klakegg/hugo:0.53 server -D -w --bind=0.0.0.0
Building sites …
...

# 清除本地端 hugo server
$ make cleandocker
# Remove retailbase containers
docker ps -f name=hugo-server -aq | xargs docker rm -f
...
```