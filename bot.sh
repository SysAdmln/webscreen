#!/usr/bin/env bash
wwwsend=/home/arturius/webscreen/user.png
fl=/home/arturius/webscreen/fl # check if the generation is working
#last_id_file=/home/arturius/webscreen/tel_id
#last_id=0
token= #bot token @BotFather
tele_url="https://api.telegram.org/bot${token}"

if [ -f "$fl" ]; then
	exit 0
else
	touch $fl
	updates=$(curl -s "${tele_url}/getUpdates")
	count_update=$(echo $updates | jq -r ".result | length")

	for ((i = 0; i < $count_update; i++)); do
		update=$(echo $updates | jq -r ".result[$i]")
		message=$(echo $update | jq -r ".message.text")
		urlmessage=$(echo $message | grep https)
		if [ $urlmessage ]; then

			last_id=$(echo $update | jq -r ".update_id")
			message_id=$(echo $update | jq -r ".message.message_id")
			chat_id=$(echo $update | jq -r ".message.chat.id")
			username=$(echo $update | jq -r ".message.from.first_name")

			curl -s "${tele_url}/sendMessage" \
				--data-urlencode "chat_id=${chat_id}" \
				--data-urlencode "reply_to_message_id=${message_id}" \
				--data-urlencode "text=@${username} жди ща все будет 😉"

			/usr/bin/docker run --rm -v /home/arturius/webscreen/:/tmp/screenshot sysadmln/webscreen $message user.png --ua "5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36"
			text=$(curl -s "${tele_url}/sendPhoto" \
				--form "chat_id=${chat_id}" \
				--form photo=@"${wwwsend}" \
				--form reply_to_message_id="${message_id}" |
				jq -r ".description" |
				awk '{print $3}')
			case $text in
			"PHOTO_INVALID_DIMENSIONS")
				curl -s "${tele_url}/sendDocument" \
					--form "chat_id=${chat_id}" \
					--form document=@"${wwwsend}" \
					--form reply_to_message_id="${message_id}"
				;;
			"ERROR") ;;
			esac

			rm -f ${wwwsend}
		fi
	done
	last_id=$(($last_id + 1))
	#сброс getUpdates last_id + 1
	curl -s "${tele_url}/getUpdates?offset=$last_id"
	rm -f ${fl}
fi
