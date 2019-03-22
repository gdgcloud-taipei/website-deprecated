---
title: "在kubernetes上使用kube-lego自動更新Let’s Encrypt TLS憑證"
date: 2017-06-29T21:20:00-07:00
draft: false
banner: "https://cdn-images-1.medium.com/max/1600/1*yepzWDlIbehNB_IDmKrEtg.gif"
author: "GCPUG TW"
translator: ""
originallink: ""
translatorlink: ""
reviewer:  ["GCPUG.TW"]
reviewerlink:  [""]
authorlink: ""
summary: "在k8s上架好了一個服務之後通常下一件事就是把它公開讓大家都可以使用，這時候你有很多選擇，通常會使用ingress來處理。這時候k8s會產生一組public IP，接下來只需要把DNS指到這個IP你的服務就完成部署了。可是部署完成之後的連線是未加密的會有安全上的疑慮，這時候我們就需要一個TLS憑證"
tags: ["TSL", "kubernets", "kube-lego", "Encrypt"]
categories: ["kubernetes"]
keywords: ["TSL", "kubernets", "kube-lego", "Encrypt"]
---

在k8s上架好了一個服務之後通常下一件事就是把它公開讓大家都可以使用，這時候你有很多選擇，通常會使用ingress來處理。這時候k8s會產生一組public IP，接下來只需要把DNS指到這個IP你的服務就完成部署了。可是部署完成之後的連線是未加密的會有安全上的疑慮，這時候我們就需要一個[TLS憑證](https://zh.wikipedia.org/wiki/%E5%82%B3%E8%BC%B8%E5%B1%A4%E5%AE%89%E5%85%A8%E5%8D%94%E8%AD%B0)。

取得TLS憑證的方式有很多種，大多是付費的服務，不過有一個佛心組織 — [Let's Encrypt](https://letsencrypt.org/)提供免費的憑證發放服務。要取得憑證你必須證明你是你這個網域的擁有者，怎麼證明呢？有很多方法，細節可以查看[ACME](https://ietf-wg-acme.github.io/acme/)。

kube-lego目前只有實作simple HTTP，簡單的說就是產生一組token給你放到你的網站的/.well-known/acme-challenge/，放好之後讓Let's Encrypt去讀取這個網址並確認token是不是符合，通過之後才會發放給你這個憑證。而且憑證是會過期的，於是就得有更新的機制。kube-lego很方便地把這些都處理好了。

最低需求：

*   Kubernetes 1.2+
*   相容的ingress controller (nginx or GCE see[here](https://github.com/jetstack/kube-lego#ingress-controllers))，如果你是用GKE的話Google都幫你搞定了 😆
*   一個可以運行的ingress
*   P.S. 目前還不適合使用在正式環境中 😆


步驟：

首先需要針對你的ingress做修改，kube-lego將會尋找有`[kubernetes.io/tls-acme:](http://kubernetes.io/tls-acme:) "true"`annotation的ingress object：

```yaml
metadata:
  annotations:
    [kubernetes.io/tls-acme:](http://kubernetes.io/tls-acme:) "true"
```

然後kube-lego會看spec.tls這個設定並且幫每一個host entry去跟Let's Encrypt申請憑證，範例如下：

```yaml
spec:
 tls:
  - secretName: mysql-tls
    hosts:
    - [phpmyadmin.example.com](http://phpmyadmin.example.com/)
    - [mysql.example.com](http://mysql.example.com/)
```

secretName是secret object的名稱，必須是namespace中唯一的，不然會被蓋掉，這是用來存放取回來的憑證。

一個完整的ingress.yml可以參考如下:

```yaml
apiVersion: extensions/v1beta1 
kind: Ingress 
metadata:   
    name: mysql
    annotations:     
        # 重要！必填！ 不然kube-lego不會管這個ingress
        [kubernetes.io/tls-acme:](http://kubernetes.io/tls-acme:) "true" 
        # 選擇你的ingress controller(gce or nginx)
        [kubernetes.io/ingress.class:](http://kubernetes.io/ingress.class:) "gce"
spec:   
    # this enables tls for the specified domain names   
    tls:
    - secretName: mysql-tls
        hosts:
        - [mysql.example.com](http://mysql.example.com/)
    rules:
    - host: [phpmyadmin.example.com](http://phpmyadmin.example.com/)
        http:
            paths:
            - path: /
                backend:
                    serviceName: mysql
                    servicePort: 80
```

然後要設定一個deployment把 kube-lego部署上去，設定範例可以參考[這個](https://github.com/jetstack/kube-lego/blob/master/examples/gce/lego/deployment.yaml)，其中比較需要注意的是：

*   LEGO\_EMAIL跟LEGO\_POD\_IP是必填，我們可以用一個config map來設定
*   LEGO\_URL預設是Let's Encrypt的staging server([https://acme-staging.api.letsencrypt.org/directory](https://acme-staging.api.letsencrypt.org/directory))，也就是測試用的，如果一切都沒問題的話就可以把這一項改成[https://acme-v01.api.letsencrypt.org/directory](https://acme-v01.api.letsencrypt.org/directory)來取得正式TLS憑證，要注意正式的憑證有次數的限制(目前是一週20次)，如果你沒有確定可以跑得起來就直接去踹正式URL的話很容易被Let's Encrypt ban掉的。

  

完成之後可以查看secret有沒有正確儲存：

```shell
> kubectl describe secrets mysql-tls
Name: mysql-tls
Namespace: default
Labels: <none>
Annotations: [kubernetes.io/tls-acme=true](http://kubernetes.io/tls-acme=true)

Type: [kubernetes.io/tls](http://kubernetes.io/tls)

Data
====
tls.crt: 3481 bytes
tls.key: 1679 bytes
```

OK的話就TLS certificate就設定好了。你可以自己去拿出來用，或者你用GKE的L7 loadbalancer的話kube-lego也很聰明的可以自動幫你處理好，等待一會兒GKE確認各service的health status是OK的之後你的https就通了！Congratulations!

  

![](https://cdn-images-1.medium.com/max/1600/1*yepzWDlIbehNB_IDmKrEtg.gif)

  

我們借用作者的精美GIF說明來看看裡面到底做了什麼… 如果覺得一直動很煩可以看[這裡](https://www.slideshare.net/mjbarks/an-introduction-to-kubelego)(第10頁開始)。左邊一排都是kube-lego相關的k8s object，首先因為kube-lego需要連接到Let's Encrypt的主機所以他要有一組service以及ingress以對外連線，然後他需要一個secret來存放從Let's Encrypt建立的帳號密碼。右邊可以看到申請回來的TLS certificate也是放在secret裡面，你自己service的ingress只要設定好了就會自動去找對應的secret來做TLS。詳細步驟如下：

1.  kube-lego pod會定期(預設間隔8小時)掃描有annotation的ingress並且確認是否需要申請/更新certificate(如果現有certificate將會在30天內過期就會更新)
2.  如果需要的話就從kube-lego ingress設定challenge需要使用的路徑(/.well-known/acme-challenge/)
3.  然後讀取帳號密碼來跟Let's Encrypt主機連線
4.  Let's Encrypt主機會驗證剛剛設定好的路徑(/.well-known/acme-challenge/)，正確的話就會發放certificate
5.  kube-lego把certificate存入secret
6.  大功告成！

### reference:

1.  作者blog: [https://blog.jetstack.io/blog/kube-lego/](https://blog.jetstack.io/blog/kube-lego/)
2.  Github repo: [https://github.com/jetstack/kube-lego](https://github.com/jetstack/kube-lego)
3.