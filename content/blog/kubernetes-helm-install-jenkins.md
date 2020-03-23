---
title: 在 Kubernetes 上透過 helm 來安裝 jenkins 服務
date: 2017-09-03T10:06:00.000Z
draft: false
banner: >-
  https://lh5.googleusercontent.com/ULSwKU-qYItW-P1Sy4mIe7AWcRUGcu4DaB9eSWdKJi0vlssLHtb89CVizvfNF4DmnyNTGLIzbKzwSZca6dBR-_cQRX8CH3M6PF1a1ad7Y97UsmL5G8ETJix6Db8FoNifUyBYt0pw
author: Simon Su
translator: null
originallink: null
translatorlink: null
reviewer:
  - GDGCloud Taipei
reviewerlink:
  - null
authorlink: null
summary: >-
  Kubernetes由於透過yaml檔描述了所要安裝的系統架構，因此要把一些應用服務透過yaml檔來封裝成線上直接安裝即可使用的應用將不再是夢想，而helm即是提供一個簡單的平台讓我們可以快速地使用第三方服務所提供的腳本，快速啟用您想要用的服務...
tags:
  - kubernetes
  - helm
  - jenkins
categories:
  - kubernetes
  - COMPUTE
keywords:
  - kubernetes
  - helm
  - jenkins

---

Kubernetes由於透過yaml檔描述了所要安裝的系統架構，因此要把一些應用服務透過yaml檔來封裝成線上直接安裝即可使用的應用將不再是夢想，而helm即是提供一個簡單的平台讓我們可以快速地使用第三方服務所提供的腳本，快速啟用您想要用的服務...

# 安裝helm

首先，安裝helm在mac上相對簡單，只要有安裝了brew，可以透過下面指令來安裝helm...

```bash
brew install kubernetes-helm
```

如果是其他系統的安裝，可以參考：[https://github.com/kubernetes/helm#install](https://github.com/kubernetes/helm#install)

# 初始化helm

建立helm的connect

# helm init

我們可以透過關鍵字來搜尋可用的套件，下面以jenkins package為例：

```shell
\# helm search jenkins  
NAME            VERSION  DESCRIPTION  
stable/jenkins  0.1.6    A Jenkins Helm chart for Kubernetes.

接下來，我們可以使用上面查詢出來的”Name”欄位來安裝jenkins服務...

\#  helm install stable/jenkins  
NAME:   imprecise-indri  
LAST DEPLOYED: Mon Aug 28  11:00:53  2017  
NAMESPACE: default  
STATUS: DEPLOYED  
  
RESOURCES:  
\==> v1/Secret  
NAME                     TYPE    DATA  AGE  
imprecise-indri-jenkins  Opaque  2 0s  
  
\==> v1/ConfigMap  
NAME                     DATA  AGE  
imprecise-indri-jenkins  1 0s  
  
\==> v1/PersistentVolumeClaim  
NAME                     STATUS   VOLUME    CAPACITY  ACCESSMODES  STORAGECLASS  AGE  
imprecise-indri-jenkins  Pending  standard  0s  
  
\==> v1/Service  
NAME                     CLUSTER-IP     EXTERNAL-IP  PORT(S)                         AGE  
imprecise-indri-jenkins  10.39.246.145 <pending>8080:31284/TCP,50000:31417/TCP  0s  
  
\==> v1beta1/Deployment  
NAME                     DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE  
imprecise-indri-jenkins  1 1 1 0 0s  
  
NOTES:  
1. Get your 'admin' user password by running:  
printf $(printf '\\%o' \`kubectl get secret --namespace default imprecise-indri-jenkins -o jsonpath="{.data.jenkins-admin-password\[\*\]}"\`);echo  
  
2. Get the Jenkins URL to visit by running these commands in the same shell:  
NOTE: It may take a few minutes for the LoadBalancer IP to be available.  
You can watch the status of  by running 'kubectl get svc --namespace default -w imprecise-indri-jenkins'  
export SERVICE\_IP=$(kubectl get svc imprecise-indri-jenkins --namespace default --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}")  
 echo http://$SERVICE\_IP:8080/login  
  
3. Login with the password from step 1  and the username: admin  
  
For more information on running Jenkins on Kubernetes, visit:  
https://cloud.google.com/solutions/jenkins-on\-container-engine

```

安裝動作完成後，一開始IP位置會是”<pending>”的狀態，我們之後可以透過kubectl get svc來查看所建立的這個服務最後GKE所給予的IP位置.... 而NOTES的部分，則會顯示如何透過指令來取得...

在取得jenkins服務的預設密碼部分，如果透過上述說明會有錯誤...  

```shell
printf $(printf  '\\%o'  \`kubectl get secret --namespace default imprecise-indri-jenkins -o jsonpath="{.data.jenkins-admin-password\[\*\]}"\`);echo  
error: error executing jsonpath "{.data.jenkins-admin-password\[\*\]}": string is not array or slice  
\-bash: printf: Error: invalid number  
\-bash: printf: executing: invalid number  
...  
\-bash: printf: {}{"name":"imprecise-indri-jenkins",: invalid number  
\-bash: printf: {}{"app":"imprecise-indri-jenkins",: invalid number  
\-bash: printf: {}{"jenkins-admin-password":"bW9tanpXVUtxRw==",: invalid number  
kamnsurclchrdj
```

debug一下，上面說明password不是array，我們先將主要的指令部分抽離，然後將password的array部分拿掉執行看看...

```shell
# kubectl get secret --namespace  default imprecise-indri-jenkins -o jsonpath="{.data.jenkins-admin-password}"
W9ta…….Rw==
```

上面得到的結果將是base64 encode過的文件內容(因為kubernetes的secret，基本上是用base64來做encode)，我們可以透過base64的指令來做decide...

```shll
# kubectl get secret --namespace  default imprecise-indri-jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode  
mo...KqG
```


因此我們可以透過kubectl get svc取到的IP位置然後透過8080 port來連線，然後使用admin / mo... KqG當作帳號密碼來連線...

![](https://lh5.googleusercontent.com/ULSwKU-qYItW-P1Sy4mIe7AWcRUGcu4DaB9eSWdKJi0vlssLHtb89CVizvfNF4DmnyNTGLIzbKzwSZca6dBR-_cQRX8CH3M6PF1a1ad7Y97UsmL5G8ETJix6Db8FoNifUyBYt0pw)

## 參考

- helm安裝：https://github.com/kubernetes/helm#install

---

From: Simon Su @ GCPUG.TW