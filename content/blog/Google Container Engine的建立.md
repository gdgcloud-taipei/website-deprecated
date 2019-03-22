---
title: "Google Container Engine的建立"
date: 2017-07-12T04:06:00-07:00
draft: false
banner: "https://lh4.googleusercontent.com/ZiOOToHQBIFJIcLLdNZL95zYrlESmXXf6DVdgPHXbZqeLFAm5571FmS0q3A9L9sXgWEXgYcJyy2w66wFUZNAgwvPzjLZLVk6q8_X0HMvTD5e3aooAEFE6cPvrkVaieGpbM20nS9O"
author: "GCPUG TW"
translator: ""
originallink: ""
translatorlink: ""
reviewer:  ["GCPUG.TW"]
reviewerlink:  [""]
authorlink: ""
summary: "在Google Cloud上使用Container Engine服務來建置Container Cluster是非常方便的事，原因是因為在GKE上，他幫忙我們處理掉了網路的串接、效能管理、對外IP的連線與防火牆的授權等等... GKE是怎麼完成的呢？下面讓我們一步一步的，用比較詳細的流程來看一下每個階段Google做了什麼..."
tags: ["GCE", "Google Container Engine"]
categories: ["COMPUTE"]
keywords: ["GCE", "Google Container Engine"]
---

在Google Cloud上使用Container Engine服務來建置Container Cluster是非常方便的事，原因是因為在GKE上，他幫忙我們處理掉了網路的串接、效能管理、對外IP的連線與防火牆的授權等等... GKE是怎麼完成的呢？下面讓我們一步一步的，用比較詳細的流程來看一下每個階段Google做了什麼...

  

首先我們先建立一個GKE cluster環境，用yourls這個名稱來建立... 建立後，可以在GKE console中看到下面的資訊：

![](https://lh4.googleusercontent.com/LrbMn20dEavPZGjdSkl1p8-nHJFt4XK4abBJIstNiKFYAY0S0okzVgK6MvBlEBnq0vSFSZYsx5mRz9DWWSAz0y6D2uWdgXHCWfEACpgd7b58QLiG6BlTnTsveFozPaCEYrE7PeGQ)

  

接下來，點進yourls的cluster時候，可以看到下面的資訊... 包含cluster的master與slave以及cluster的location，k8s的版本與cluster size等資訊...

![](https://lh4.googleusercontent.com/ZiOOToHQBIFJIcLLdNZL95zYrlESmXXf6DVdgPHXbZqeLFAm5571FmS0q3A9L9sXgWEXgYcJyy2w66wFUZNAgwvPzjLZLVk6q8_X0HMvTD5e3aooAEFE6cPvrkVaieGpbM20nS9O)

  

在GKE cluster size小於10台的情況下Google會代管您的Master node，讓管理上可以忽略Master Node的部分，也可以省下Master Node的費用...

  

![](https://docs.google.com/drawings/u/0/d/s5x98jK5xBX1od70Ngz2gFg/image?w=881&h=437&rev=86&ac=1)

另外，下面有列出node pool的資訊，其中GKE上預設node與master的版本相同，而如果要做升級動作，可以針對node與master分開執行，這樣可以讓環境彼此間的影響比較小...

![](https://lh3.googleusercontent.com/zrIceGW_2kd5Gao078nR3_ETlWEuJyZ7vJqjdkZxDTJtB-_WeqdhJD6vB66G-zQtsD8PDVB1tAcj4wvA-zXqH6fqgIPxGZDzXVRlWzBgcvfkXYElCbctxJRWVdyQYDTrc_JGCWNn)

  

當Cluster架設好，我們會想... 那，就通了嗎？以Google Compute Engine的經驗，我們需要設定firewall讓cluster的環境打通，來看看firewall上的設定...

![](https://lh6.googleusercontent.com/FJPoeXY31JuT3zJfZPgne8nAr09BxVizFJL7_XwsOMmYLT6OucSTuDf0aMEFY6gxq1SxowflhlhpX7lon7x1DwTkAK7h2zqPKrWvlUDzkDSUQzoonKBRqPSvW38orHT6veaKLrGz)

  

在firewall上，GKE幫我們建立了幾個設定..

- gke-yourls…-all: 允許GKE內部Container的網段可以直接連線彼此
- gke-yourls…-ssh: 允許master node可以讓外部ssh連線進入
- gke-yourls…-vms: 允許GKE Host VM彼此之間可以互通
    

  

透過上述設定，可以讓一個GKE的Cluster可以正常運作... 接下來可以看一個應用程式部署的情況下，在網路上會有哪些改變... ^^

  
---

From: IndustrialClouds.net