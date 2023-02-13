#!/usr/bin/env bash

token=123

tele_url="https://api.telegram.org/bot${token}"

### -- main -- 

updates=$(curl -s "${tele_url}/getUpdates")
count_update=$(echo $updates | jq -r ".result | length") 
	
for ((i=0; i<$count_update; i++)); do
	update=$(echo $updates | jq -r ".result[$i]")
	echo "$update\n"
done