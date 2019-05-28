#!/bin/sh
# Analysis the blogs

# orig_json="../public/algolia.json"
# formated_json="../public/blog_list.json"
# translators="../content/translators.md"
# authors="../content/authors.md"

orig_json=${ORIG_JSON}
formated_json=${FORMATED_JSON}
translators=${TRANSLATORS}
authors=${AUTHORS}

if [ ! -f $orig_json ];then
    echo "The file $orig_json doesn't exist, please run hugo to generate it."
    exit 0
fi

cat $orig_json|jq .|cat>$formated_json
echo '''
---
title: "譯者投稿"
description: "投稿譯者文章數統計"
keywords: ["gcpug taipei"]
---

以下是投稿的譯者及譯文數目統計信息。
'''> $translators
echo -e "| 譯者 | 文章數 |\n| ---- | ---- |" >> $translators
cat $formated_json|grep translator|sort -n|cut -d ":" -f2|grep -v "null"|tr -d '"',","|uniq -c|sort -rn|awk '{ print "|" $2 " | " $1 "|"}' >> $translators
echo -e "\n提交文章線索或譯文請訪問 N/A" >> $translators

echo '''
---
title: "作者投稿"
description: "投稿作者文章數統計"
keywords: ["gcpug taipei"]
---

以下是投稿的作者及原創文章數目統計信息。
'''> $authors
echo -e "| 作者 | 文章數 |\n| ---- | ---- |" >> $authors
cat $formated_json|grep author|grep -v "authorlink"|sort|cut -d ":" -f2|tr -d ","'"'|uniq -c|sort -nr|awk '$2 { print "|" $2 " | " $1 "|"}' >> $authors
echo -e "\n投遞原創文章請訪問 N/A" >> $authors

rm ${ORIG_JSON}