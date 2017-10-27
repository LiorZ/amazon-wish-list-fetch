#!/bin/bash
if [ "$#" -eq 0 ]; then
    echo "get_wish_list.sh <List of ids, separated by spaces>"
    echo "OR"
    echo "get_wish_list.sh <File that contains ids, each one in a line>"
    exit
fi
if [ "$#" -eq 1 ] && [ -e $1 ]; then
    list=`cat $1 | tr '\n' ' '`
else
    list=`echo $@`
fi
for i in `echo "$list"`
do
    curl -s "https://www.amazon.com/wishlist/$i/ref=cm_wl_act_print_o?_encoding=UTF8&layout=standard-print&disableNav=1&visitor-view=1&items-per-page=9999" -c cookies -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.89 Safari/537.36" | egrep h5 | sed 's/<h5>//g' | sed 's/<\/h5>//g' | sed -r 's/^\s*//g' | egrep -v '>' | egrep -v '<' 
done
