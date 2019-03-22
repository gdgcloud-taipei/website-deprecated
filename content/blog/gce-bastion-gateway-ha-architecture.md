---
title: "GCE 上實作 Bastion Gateway 的 HA 架構"
date: 2017-08-18T22:26:00-07:00
draft: false
banner: "http://2.bp.blogspot.com/-CkoOWmzS7V4/WZfMMsJGWFI/AAAAAAAAAuo/ht_10-447fcLNYZnXKP2ZByPdYWg2n0DgCK4BGAYYCw/s320/image-733929.png"
author: "GCPUG TW"
translator: ""
originallink: ""
translatorlink: ""
reviewer:  ["GCPUG.TW"]
reviewerlink:  [""]
authorlink: ""
summary: "NAT(或稱Bastion主機)的架構在自建機房中常常可以見到，我們也可以將該架構在雲端環境上建置來使用... 而Google雲端的環境中，可以透過network與routing的方式搭配來建置一個具有HA(High Availability)的NAT環境，讓NAT不是單點提供服務... 下面是架構的簡單描述："
tags: ["GCE", "HA"]
categories: ["architecture"]
keywords: ["GCE", "HA"]
---

## 概念

NAT(或稱Bastion主機)的架構在自建機房中常常可以見到，我們也可以將該架構在雲端環境上建置來使用... 而Google雲端的環境中，可以透過network與routing的方式搭配來建置一個具有HA(High Availability)的NAT環境，讓NAT不是單點提供服務... 下面是架構的簡單描述：

  

[![](http://2.bp.blogspot.com/-CkoOWmzS7V4/WZfMMsJGWFI/AAAAAAAAAuo/ht_10-447fcLNYZnXKP2ZByPdYWg2n0DgCK4BGAYYCw/s320/image-733929.png)](http://2.bp.blogspot.com/-CkoOWmzS7V4/WZfMMsJGWFI/AAAAAAAAAuo/ht_10-447fcLNYZnXKP2ZByPdYWg2n0DgCK4BGAYYCw/s1600/image-733929.png)  

  

## 建置過程

### 設定網路與防火牆基本規則

首先，建議使用自建Network，好處是可以自訂內部的路由與相關防火牆規則，且可以避免影響其他主機。

  
```shell
gcloud compute networks create kankan-ha-nat \
    --mode legacy \
    --range [10.10.10.0/24](http://10.10.10.0/24)
```

為了可以測試狀態，我們允許port 22的ssh連線，因此建立允許 tcp 22 port 連線的防火牆規則...

  
```shell
gcloud compute firewall-rules create kankan-ha-nat-allow-ssh \
--allow tcp:22 --network kankan-ha-nat
```
  

在NAT server的建置上，我們需要讓內外部連線可以透通，因此將tcp:1-65535, udp:1-65535, icmp等協定打開，讓內部的網段([10.10.10.0/24)](http://10.10.10.0/24))可以透過NAT server來連線外部網路。

  
```shell
gcloud compute firewall-rules create kankan-ha-nat-allow-internal \ 
--allow tcp:1-65535,udp:1-65535,icmp \
--source-ranges [10.10.10.0/24](http://10.10.10.0/24) --network kankan-ha-nat
```
  

### 建立NAT server

然後我們將NAT server建立起來：

```shell
gcloud compute instances create nat-gateway-asia-east1-a --network kankan-ha-nat --can-ip-forward \
--zone asia-east1-a \
--image-family debian-8 \
--image-project debian-cloud \ 
--tags nat
```
  

為了實現NAT的HA可能性，我們需要另外建立一台NAT server，可以讓NAT server異常時候，有另外一台NAT server可以提供路由服務... 下面是用同樣的設定在創建一台NAT server，但是我們選擇不同的zone，讓multi zone提供更高可用性...

  
```shell
gcloud compute instances create nat-gateway-asia-east1-c --network kankan-ha-nat --can-ip-forward \
--zone asia-east1-c \
--image-family debian-8 \
--image-project debian-cloud  
--tags nat
```
  
附註：上面NAT主機建立的過程中，必需要開啟network中的"can-ip-forward"參數，開啟後該主機才能夠提供路由之功能...

## 建立測試主機與連線環境

接下來建立內部服務主機，也就是我們想藏在NAT Gateway後面的重要機器，該主機會具備一個"no-ip"標籤，該標籤主要會結後後面建立的路由規則，讓路由經過指定的NAT主機...

```shell
gcloud compute instances create  no-ip-instance --network kankan-ha-nat --no-address \
--zone asia-east1-a \
--image-family debian-8 \
--image-project debian-cloud \
--tags no-ip
```
  
為了方便測試，我們另外建立測試時使用的 jumper 主機，當作跳到內部主機的跳板...，該主機必須與內部主機在同一個network下面...

  
```shell
gcloud compute instances create kankan-jumper --network kankan-ha-nat \ 
--zone asia-east1-b \
--image-family debian-8 \
--image-project debian-cloud
```
  

## 設定NAT主機之路由

接下來需要準備NAT主機的路由，指定所有"no-ip"的主機可以走該路由進出internet...

  
```shell
gcloud compute routes create  no-ip-internet-route-a --network kankan-ha-nat \
--destination-range [0.0.0.0/0](http://0.0.0.0/0) \
--next-hop-instance nat-gateway-asia-east1-a \
--next-hop-instance-zone asia-east1-a \
--tags no-ip --priority 800
```
  

我們也需要針對第二台NAT主機建立同樣的路由...

  
```shell
gcloud compute routes create  no-ip-internet-route-c --network kankan-ha-nat \
--destination-range [0.0.0.0/0](http://0.0.0.0/0) \
--next-hop-instance nat-gateway-asia-east1-c \
--next-hop-instance-zone asia-east1-c \
--tags no-ip --priority 800
```
  

當兩個路由同時存在時，只要該路由可運作，則內部主機之網路會由可運作的路由提供網路，如果整在使用的 NAT server 異常或關機，則GCE會自動使用另一台 NAT server 主機提供服務。

## 設定NAT主機

NAT主機需要進行一些路由forward的設定，我們需要連線進入所建立的NAT主機上進行設定：

  
```shell
gcloud compute ssh nat-gateway-asia-east1-a --zone asia-east1-a  
gcloud compute ssh nat-gateway-asia-east1-c --zone asia-east1-c
```
  

設定的內容如下：

  
```shell
sudo vi /etc/rc.local  
sysctl -w net.ipv4.ip_forward=1  
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
```
  

其中net.ipv4.ip\_forward=1是啟動主機內 ip forward 的功能，iptables的那段則是啟用封包forward到eth0網卡的功能... 這些設定寫到 "/etc/rc.local" 則可以讓主機再重新開機後可以自動起來...

## 測試

最後我們可以透過 jumper server 做跳板，再 ssh 連線進到 no-ip-instance 主機中，然後 ping 外部的 ip ...

  
```shell
gcloud compute ssh kankan-jumper --zone asia-east1-b  
ssh no-ip-instance  
ping 8.8.8.8
```

只要上面 ping 8.8.8.8 有實際成功，則我們可以測試輪流關閉(只保留一台NAT主機)時，內部這台主機的ping運作狀況...

  

## 參考

*   GCE document - Securely Connecting to VM Instances : [https://cloud.google.com/solutions/connecting-securely#bastion](https://cloud.google.com/solutions/connecting-securely#bastion)
    

---
  
作者：KanKan