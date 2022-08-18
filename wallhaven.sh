#!/bin/bash

which jq > /dev/null || sudo apt install -y jq
which aria2c >/dev/null || sudo apt install -y aria2
which curl >/dev/null || sudo apt install -y curl

# categories 100/101/111* (general/anime/people) Turn categories on(1) or off(0)
# purity     100/110/111  (sfw/sketchy/nsfw)     
curl -sX GET 'https://wallhaven.cc/api/v1/search?ratios=16x9&purity=100&categories=100&sorting=views' | jq .data[].path | cut -d '"' -f 2 | tee uris.txt
#cat uris.txt
directory="$HOME/Wallpapers"
[ ! -d ${directory} ] && mkdir ${directory}
aria2c -d${directory} -j16 -c -x16 -k1M -s16 --optimize-concurrent-downloads true  -i uris.txt

rm uris.txt

